#!/bin/sh

echo ">> Annotating k8s nodes."
kubectl annotate node kluster-worker topology.kubernetes.io/zone=rack1
kubectl annotate node kluster-worker2 topology.kubernetes.io/zone=rack2
kubectl annotate node kluster-worker3 topology.kubernetes.io/zone=rack3

echo ">> Checking zone annotations show our rack names."
kubectl get nodes -o jsonpath='{..metadata.annotations.topology\.kubernetes\.io/zone}{"\n"}'