{{/*
Expand the name of the chart.
*/}}
{{- define "app-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app-service.labels" -}}
helm.sh/chart: {{ include "app-service.chart" . }}
{{ include "app-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app-service.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "app-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- .Values.serviceAccount.name | default (printf "ksa-%s" (trimSuffix "-service"  (include "app-service.fullname" .))) .Values.serviceAccount.name | quote }}
{{- else }}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{/*
Create the name of the google service account to use
*/}}
{{- define "app-service.googleServiceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- printf "gsa-%s@serai-traceability-%s.iam.gserviceaccount.com" (trimSuffix "-service" (include "app-service.fullname" .)) .Values.env }}
{{- end }}
{{- end }}


{{/*
Create the name of the google SHORT service account to login db
*/}}
{{- define "app-service.gsaDBName" -}}
{{- if .Values.cloudSQLProxy.enabled }}
{{- printf "gsa-%s@serai-traceability-%s.iam" (trimSuffix "-service" (include "app-service.fullname" .)) .Values.env }}
{{- end }}
{{- end }}


{{/*
Create the name of the db instance to use
*/}}
{{- define "app-service.dbInstanceName" -}}
{{- if .Values.cloudSQLProxy.enabled }}
{{- printf "serai-traceability-%s:asia-east2:serai-traceability-asea2-pgsql-%s-%s" .Values.env .Values.cloudSQLProxy.instance_no .Values.env }}
{{- end }}
{{- end }}

{{/*
Create the name of the gcs bucket to use
*/}}
{{- define "app-service.bucketName" -}}
{{- printf "serai-traceability-bucket-1-asia-east2-%s" .Values.env }}
{{- end }}

