{{/*
Expand the name of the chart.
*/}}
{{- define "llama-stack-operator-instance.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "llama-stack-operator-instance.fullname" -}}
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
{{- define "llama-stack-operator-instance.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "llama-stack-operator-instance.labels" -}}
helm.sh/chart: {{ include "llama-stack-operator-instance.chart" . }}
{{ include "llama-stack-operator-instance.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "llama-stack-operator-instance.selectorLabels" -}}
app.kubernetes.io/name: {{ include "llama-stack-operator-instance.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the ConfigMap
*/}}
{{- define "llama-stack-operator-instance.configMapName" -}}
{{- if .Values.configMap.name }}
{{- .Values.configMap.name }}
{{- else }}
{{- printf "%s-config" (include "llama-stack-operator-instance.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create the name of the LlamaStackDistribution instance
*/}}
{{- define "llama-stack-operator-instance.instanceName" -}}
{{- if .Values.name }}
{{- .Values.name }}
{{- else }}
{{- include "llama-stack-operator-instance.fullname" . }}
{{- end }}
{{- end }}