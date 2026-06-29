# ==========================================
# 1. General & Metadata
# ==========================================
variable "environment" {
  type        = string
  description = "The environment name (e.g., devint, uat, stage, main)"
}

variable "customer_name" {
  type        = string
}


# Watershed Resource Group

variable "rg_name" {
  type        = string
  description = "Resource group name"
}


variable "location" {
  type        = string
  description = "The Azure region for the resources"
}

variable "tenant_id" {
  type        = string
  description = "The Azure AD tenant ID"
}

# ==========================================
# 2. Remote State Variables (Auragxp Lookups)
# ==========================================
variable "tfstate_rg" {
  type        = string
  description = "Resource Group where Auragxp tfstate is stored"
}

variable "tfstate_storage_account" {
  type        = string
  description = "Storage Account where Auragxp tfstate is stored"
}

variable "tfstate_container" {
  type        = string
  description = "Container name where Auragxp tfstate is stored"
}



# ==========================================
# 3. Key Vault Variables
# ==========================================
variable "keyvault_name" {
  type        = string
}

variable "terraform_kv_secret_user_object_id" {
  type        = string
  description = "Object ID of the Service Principal running the pipeline (to grant Secret Officer role)"
}

variable "keyvault_secrets" {
  type        = map(map(any))
  description = "Map of secrets to create (keys only)"
  default     = {}
}

variable "keyvault_secret_values" {
  type        = map(string)
  description = "Map of secret values (sensitive)"
  default     = {}
  sensitive   = true
}

# ==========================================
# 4. Storage Account Variables
# ==========================================
variable "storage_account_name" {
  type        = string
}

variable "storage_location" {
  type        = string
  description = "Location for the storage account (can be same as var.location)"
}

# ==========================================
# 5. Function App Variables
# ==========================================
variable "function_app_name" {
  type        = string
}

variable "function_app_location" {
  type        = string
  description = "Location for the function app"
}