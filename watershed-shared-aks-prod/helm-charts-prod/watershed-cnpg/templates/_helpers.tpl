{{/*
Expand the name of the chart.
*/}}
{{- define "watershed-cnpg.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "watershed-cnpg.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "watershed-cnpg.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watershed-cnpg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "watershed-cnpg.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "watershed-cnpg.labels" -}}
helm.sh/chart: {{ include "watershed-cnpg.chart" . }}
{{ include "watershed-cnpg.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
environment: {{ .Values.environment }}
{{- end }}

{{/*
Database cluster name
*/}}
{{- define "watershed-cnpg.clusterName" -}}
{{- if .Values.restore.enabled }}
{{- .Values.restore.cloneClusterName }}
{{- else }}
{{- .Values.cluster.name | default (include "watershed-cnpg.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Database namespace
*/}}
{{- define "watershed-cnpg.namespace" -}}
{{- .Values.cluster.namespace | default .Release.Namespace }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "watershed-cnpg.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
