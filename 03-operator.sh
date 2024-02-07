#!/bin/sh
. ./config

echo ">> Installing Redpanda Operator using operator.yaml"
helm install -f operator.yaml redpanda-controller "redpanda/operator" \
    -n "${RP_NAMESPACE}" --create-namespace
kubectl -n "${RP_NAMESPACE}" rollout status -w "deployment/redpanda-controller-operator"