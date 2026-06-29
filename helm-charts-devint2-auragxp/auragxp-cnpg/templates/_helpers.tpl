{{/*
Expand the name of the chart.
*/}}
{{- define "auragxp-cnpg-devint2.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "auragxp-cnpg-devint2.fullname" -}}
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
{{- define "auragxp-cnpg-devint2.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auragxp-cnpg-devint2.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auragxp-cnpg-devint2.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "auragxp-cnpg-devint2.labels" -}}
helm.sh/chart: {{ include "auragxp-cnpg-devint2.chart" . }}
{{ include "auragxp-cnpg-devint2.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
environment: {{ .Values.environment }}
{{- end }}

{{/*
Database cluster name
*/}}
{{- define "auragxp-cnpg-devint2.clusterName" -}}
{{- if .Values.restore.enabled }}
{{- .Values.restore.cloneClusterName }}
{{- else }}
{{- .Values.cluster.name | default (include "auragxp-cnpg-devint2.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Database namespace
*/}}
{{- define "auragxp-cnpg-devint2.namespace" -}}
{{- .Values.cluster.namespace | default .Release.Namespace }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "auragxp-cnpg-devint2.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
