#!/bin/bash

set -x

ROOT_TOKEN=$(cat cluster-keys.json | jq -r ".root_token")

kubectl exec vault-0 -- vault login ${ROOT_TOKEN} 

# kubectl exec vault-0 -- vault token create -id=root


