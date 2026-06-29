{{/*
Expand the name of the chart.
*/}}
{{- define "auragxp-frontend-devint2.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "auragxp-frontend-devint2.fullname" -}}
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
{{- define "auragxp-frontend-devint2.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "auragxp-frontend-devint2.labels" -}}
helm.sh/chart: {{ include "auragxp-frontend-devint2.chart" . }}
{{ include "auragxp-frontend-devint2.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ .Values.appName }}
environment: {{ .Values.environment | default "uat" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auragxp-frontend-devint2.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auragxp-frontend-devint2.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ .Values.appName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "auragxp-frontend-devint2.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "auragxp-frontend-devint2.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
