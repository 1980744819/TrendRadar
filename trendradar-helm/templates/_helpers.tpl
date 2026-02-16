{{/*
Common labels
*/}}
{{- define "trendradar.labels" }}
  helm.sh/chart: {{ include "trendradar.chart" . }}
  app.kubernetes.io/name: {{ include "trendradar.name" . }}
  app.kubernetes.io/instance: {{ .Release.Name }}
  app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "trendradar.selectorLabels" }}
  app.kubernetes.io/name: {{ include "trendradar.name" . }}
  app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Full name
*/}}
{{- define "trendradar.fullname" }}
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
Chart name
*/}}
{{- define "trendradar.chart" }}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Name of the application
*/}}
{{- define "trendradar.name" }}
  {{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "trendradar.serviceAccountName" }}
  {{- if .Values.serviceAccount.create }}
    {{- default (include "trendradar.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.serviceAccount.name }}
  {{- end }}
{{- end }}
