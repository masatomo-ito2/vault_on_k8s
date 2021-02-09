#!/bin/bash

set -x

UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")

kubectl exec vault-0 -- vault operator unseal ${UNSEAL_KEY}
kubectl exec vault-1 -- vault operator unseal ${UNSEAL_KEY}
kubectl exec vault-2 -- vault operator unseal ${UNSEAL_KEY}


