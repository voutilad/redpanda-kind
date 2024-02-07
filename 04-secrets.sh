#!/bin/sh
. ./config

PASSPHRASE="$(./passphrase/generate.sh | tr -d '\n')"

# XXX for now this creates 2 entries based on how the Redpanda and Topic CRDs work.
# XXX also, uses /dev/stdin since kubectl doesn't use - for stdin!
echo ">> Creating Redpanda secrets"
kubectl create secret generic redpanda-admin-password -n "${RP_NAMESPACE}" \
    --from-literal=password="${PASSPHRASE}"

kubectl create secret generic redpanda-superuser -n "${RP_NAMESPACE}" \
    --from-file=superusers.txt=/dev/stdin << EOF
admin:${PASSPHRASE}:SCRAM-SHA-512
EOF
