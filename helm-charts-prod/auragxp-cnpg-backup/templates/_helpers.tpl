{{/*
Expand the name of the chart.
*/}}
{{- define "auragxp-cnpg.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "auragxp-cnpg.fullname" -}}
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
{{- define "auragxp-cnpg.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auragxp-cnpg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auragxp-cnpg.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "auragxp-cnpg.labels" -}}
helm.sh/chart: {{ include "auragxp-cnpg.chart" . }}
{{ include "auragxp-cnpg.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Database cluster name
*/}}
{{- define "auragxp-cnpg.clusterName" -}}
{{- .Values.cluster.name | default (include "auragxp-cnpg.fullname" .) }}
{{- end }}

{{/*
Database namespace
*/}}
{{- define "auragxp-cnpg.namespace" -}}
{{- .Values.cluster.namespace | default .Release.Namespace }}
{{- end }}

{{/*
ServiceAccount name (existing SA – workload identity)
*/}}
{{- define "auragxp-cnpg.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}

