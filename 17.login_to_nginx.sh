#!/bin/bash

kubectl exec -it \
    $(kubectl get pod -l app=nginx -o jsonpath="{.items[0].metadata.name}") \
    --container nginx -- /bin/sh
