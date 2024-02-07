#!/bin/sh

# Deploy a new Kind cluster.
# XXX Does not check if one already exists.
kind create cluster --config kind.yaml
