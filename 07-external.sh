#!/bin/sh
. ./config

TEMPLATE='{{ range $_ := .items }}{{ if and (eq .kind "Endpoints") (eq .metadata.name "redpanda-external") }}{{ range $_ := (index .subsets 0).addresses }}{{ $nodeName := .nodeName }}{{ $podName := .targetRef.name }}{{ range $node := $.items }}{{ if and (eq .kind "Node") (eq .metadata.name $nodeName) }}{{ range $_ := .status.addresses }}{{ if eq .type "InternalIP" }}{{ .address }} {{ $podName }}.customredpandadomain.local{{ "\n" }}{{ end }}{{ end }}{{ end }}{{ end }}{{ end }}{{ end }}{{ end }}'

echo ">> Updating /etc/hosts."
# remove existing /etc/hosts entries for Redpanda if present
sudo sed -i '/redpandadomain/d' /etc/hosts

# update /etc/hosts with our brokers
kubectl -n "${RP_NAMESPACE}" get endpoints,node -A -o "go-template=${TEMPLATE}" \
	| sudo tee -a /etc/hosts

echo ">> Grabbing a copy of the root CA certificate."
# grab a copy of the ca certificate being used
kubectl -n "${RP_NAMESPACE}" get secret redpanda-external-root-certificate \
	-o go-template='{{ index .data "ca.crt" | base64decode }}' > ca.crt
