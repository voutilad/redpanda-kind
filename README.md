# Local Kind-based Bootstrap

Follows the guide from Redpanda's [docs](https://docs.redpanda.com/current/deploy/deployment-option/self-hosted/kubernetes/local-guide/) but adds in:

* SASL authentication and Authorization [support](https://docs.redpanda.com/current/manage/kubernetes/security/authentication/sasl-kubernetes/)
* Rack Awareness to [define failure zones](https://docs.redpanda.com/current/manage/kubernetes/kubernetes-rack-awareness/)
* Redpanda Connectors [instance](https://docs.redpanda.com/current/deploy/deployment-option/self-hosted/kubernetes/k-deploy-connectors/)

Additionally, all configuration is defined in YAML files and not one-shot commands to helm or kubectl.

## Pre-reqs
* A host with [enough resources](https://docs.redpanda.com/current/deploy/deployment-option/self-hosted/kubernetes/kubernetes-cluster-requirements/) (cpu/mem) to deploy a 3-broker Redpanda cluster
* Recent versions of Docker, `kubectl`, and `helm`
* Unzip (to unpack `rpk`)
* A user account that:
  - has sudo ability to elevate privileges
  - has access to the Docker daemon socket

## Instructions

1. Modify `config` if you want to change the k8s namespace (defaults to `redpanda`).
2. Generally, run the shell scripts in numeric order, starting with `00-kind.sh`.

## What does each YAML file do?

- `kind.yaml` -- Configuration for the Kind cluster.
- `operator.yaml` -- Configuration for the Redpanda Operator.
- `redpanda.yaml` -- Configuration for the Redpanda cluster and services (Console, etc.).
- `topic.yaml` -- Configuration for a sample topic.
- `profile.yaml` -- RPK profile for "external" connectivity to the Redpanda cluster from the host.

## What about the generated stuff?

- `password.txt` -- 

...tbc

