{{/*
Expand the name of the chart.
*/}}
{{- define "watershed-frontend-istio.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "watershed-frontend-istio.fullname" -}}
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
{{- define "watershed-frontend-istio.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "watershed-frontend-istio.labels" -}}
helm.sh/chart: {{ include "watershed-frontend-istio.chart" . }}
{{ include "watershed-frontend-istio.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ .Values.appName }}
environment: {{ .Values.environment | default "env" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watershed-frontend-istio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "watershed-frontend-istio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ .Values.appName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "watershed-frontend-istio.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "watershed-frontend-istio.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
