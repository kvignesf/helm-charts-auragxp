############################################
# Remote State - Level 1 (AKS)
############################################
data "terraform_remote_state" "level1" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_rg
    storage_account_name = var.tfstate_storage_account
    container_name       = var.tfstate_container
    key                  = "level1.tfstate"
  }
}

############################################
# Remote State - Level 2 (Auragxp - App Service Plan)
############################################
data "terraform_remote_state" "level2_auragxp" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_rg
    storage_account_name = var.tfstate_storage_account
    container_name       = var.tfstate_container
    key                  = "level2.tfstate"
  }
}

locals {
  common_tags = {
    env     = var.environment
    proj    = var.customer_name
    caf_lvl = "2"
  }
  # Extract IDs from existing levels
  existing_asp_id        = data.terraform_remote_state.level2_auragxp.outputs.app_service_plan_id
  aks_kubelet_object_id = data.terraform_remote_state.level1.outputs.aks_kubelet_identity_object_id
  aks_oidc_url = data.terraform_remote_state.level1.outputs.oidc_issuer_url
}


module "rg" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.0"
  name     = var.rg_name
  location = var.location
  tags     = local.common_tags
}


############################################
# 2. Public IPs (Redis & DB)
############################################
resource "azurerm_public_ip" "static_ips" {
  for_each = toset(["redis", "db"])

  # Matches your script naming: global-non-prod-redis-pip
  name = "${var.customer_name}-${var.environment}-${each.key}-pip"
  resource_group_name = module.rg.name
  location            = "eastus"
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(local.common_tags, {
    Purpose = "StaticPublicIP"
  })
}


############################################
# Azure Key Vault
############################################
module "keyvault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.1"

  name                = var.keyvault_name
  resource_group_name = module.rg.name
  location            = var.location
  tenant_id           = var.tenant_id

  sku_name                      = "standard"
  public_network_access_enabled = true

  purge_protection_enabled = false


  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

   role_assignments = {
    deployment_user = {
      role_definition_id_or_name = "Key Vault Secrets Officer"
      principal_id               = var.terraform_kv_secret_user_object_id
    }
     aks_secrets_user = {
      role_definition_id_or_name = "Key Vault Secrets User"
      principal_id               = local.aks_kubelet_object_id 
    }
  }
  
  secrets       = var.keyvault_secrets
  secrets_value = var.keyvault_secret_values


  tags = local.common_tags
}


############################################
# Storage Account – Static Website
############################################
module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                = var.storage_account_name
  resource_group_name = module.rg.name
  location            = var.storage_location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true

  network_rules = {
    default_action = "Allow"
    bypass         = ["AzureServices"]
    ip_rules       = []
    subnet_ids     = []
  }

   #CORS Configuration
  blob_properties = {
    cors_rule = [
      {
        allowed_headers    = ["*"]
        allowed_methods    = ["GET", "POST", "PUT", "PATCH"] 
        allowed_origins    = ["*"] 
        exposed_headers    = ["*"]
        max_age_in_seconds = 3600
      }
    ]
  }


  static_website = {
    website = {
      index_document     = "index.html"
      error_404_document = "404.html"
    }
  }

  containers = {
    lms = {
      name                  = "lms-assets"
      container_access_type = "private"
    }
    web = {
      name          = "web"
      public_access = "Container" # Corresponds to 'Container' access level
    }
  }



  tags = local.common_tags
}


############################################
# Function App (Using Existing App Service Plan)
############################################

module "function_app" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.19.1"

  kind                     = "functionapp"
  name                     = var.function_app_name
  location                 = var.function_app_location
  os_type                  = "Windows"
  resource_group_name      = module.rg.name
  https_only               = true
  service_plan_resource_id = local.existing_asp_id

  #Storage access via connection string (keys)
  storage_account_name = module.storage_account.name
  #storage_account_access_key  = data.azurerm_storage_account.function_storage.primary_access_key
  storage_account_access_key = module.storage_account.resource.primary_access_key

  storage_authentication_type = "StorageAccountConnectionString"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~22"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    AzureWebJobsFeatureFlags     = "EnableWorkerIndexing"
    
    BLOB_CONNECTION_STRING = module.storage_account.resource.primary_connection_string
    PostgresConnectionString  = "dummy-postgres-connection-string"
    REDIS_HOST                   = "dummy-redis-host"
    REDIS_PORT                   = "6379"
    REDIS_PASSWORD               = "dummy-redis-password"

  }

  tags = local.common_tags
}
