#!/bin/bash

set -x

kubectl exec -it \
    $(kubectl get pod -l app=nginx -o jsonpath="{.items[0].metadata.name}") \
    --container nginx -- cat /vault/secrets/mysecret.txt
