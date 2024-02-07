#!/bin/sh
. ./config

echo ">> Deploying Redpanda cluster."
kubectl apply -f redpanda.yaml -n "${RP_NAMESPACE}"
