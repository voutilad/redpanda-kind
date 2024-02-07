#!/bin/sh
. ./config

echo ">> Updating Helm repos."
helm repo add jetstack "https://charts.jetstack.io"
helm repo add redpanda "https://charts.redpanda.com"
helm repo update

echo ">> Installing cert-manager. Please be patient as this may take a moment."
helm install cert-manager jetstack/cert-manager \
	--set installCRDs=true \
	--namespace cert-manager  \
	--create-namespace

echo ">> Installing Redpanda CRDs."
kubectl kustomize "https://github.com/redpanda-data/redpanda-operator/src/go/k8s/config/crd" \
	| kubectl apply -f -
