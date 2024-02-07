#!/bin/sh
. ./config

echo ">> Updating topic."
kubectl apply -f topic.yaml -n "${RP_NAMESPACE}"
