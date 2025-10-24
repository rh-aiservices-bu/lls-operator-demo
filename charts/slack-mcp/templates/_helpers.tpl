{{/*
Expand the name of the chart.
*/}}
{{- define "slack-mcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "slack-mcp.fullname" -}}
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
{{- define "slack-mcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "slack-mcp.labels" -}}
helm.sh/chart: {{ include "slack-mcp.chart" . }}
{{ include "slack-mcp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "slack-mcp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "slack-mcp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: slack-mcp-server
{{- end }}

{{/*
Secret name
*/}}
{{- define "slack-mcp.secretName" -}}
{{- if .Values.slack.existingSecret }}
{{- .Values.slack.existingSecret }}
{{- else }}
{{- include "slack-mcp.fullname" . }}-secret
{{- end }}
{{- end }}
