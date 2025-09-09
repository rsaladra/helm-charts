{{/*
Expand the name of the chart.
*/}}
{{- define "zookeeper.name" -}}
{{- include "common.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "zookeeper.fullname" -}}
{{- include "common.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zookeeper.chart" -}}
{{- include "common.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zookeeper.labels" -}}
{{- include "common.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zookeeper.selectorLabels" -}}
{{- include "common.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "zookeeper.annotations" -}}
{{- include "common.annotations" . -}}
{{- end }}

{{/*
Return the proper ZooKeeper image name
*/}}
{{- define "zookeeper.image" -}}
{{- include "common.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "zookeeper.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create a server list string based on fullname, namespace, # of servers
in a format like "zkhost1:port:port;zkhost2:port:port"
*/}}
{{- define "zookeeper.serverlist" -}}
{{- $namespace := .Release.Namespace }}
{{- $name := include "zookeeper.fullname" . -}}
{{- $peersPort := .Values.service.ports.quorum -}}
{{- $leaderElectionPort := .Values.service.ports.leaderElection -}}
{{- $zk := dict "servers" (list) -}}
{{- range $idx, $v := until (int .Values.replicaCount) }}
{{- $noop := printf "%s-%d.%s-headless.%s.svc.cluster.local:%d:%d" $name $idx $name $namespace (int $peersPort) (int $leaderElectionPort) | append $zk.servers | set $zk "servers" -}}
{{- end }}
{{- printf "%s" (join ";" $zk.servers) | quote -}}
{{- end -}}