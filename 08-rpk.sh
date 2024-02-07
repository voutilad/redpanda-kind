#!/bin/sh
. ./config

if [ ! -x "./rpk" ]; then
    echo ">> Downloading rpk."
    curl -o "/tmp/rpk-linux-${ARCH}.zip" \
        -L "https://github.com/redpanda-data/redpanda/releases/latest/download/rpk-linux-${ARCH}.zip"
    unzip -o "/tmp/rpk-linux-${ARCH}.zip"
fi

PASSPHRASE=$(\
    kubectl get -n redpanda secret redpanda-admin-password \
        -o jsonpath='{.data.password}' | base64 -d | tr -d '\n')

echo ">> Installing RPK profile."
./rpk profile create kind-profile --from-profile "rpk-profile.yaml"
./rpk profile set "pass=${PASSPHRASE}"

echo ">> Testing cluster connectivity."
./rpk cluster info