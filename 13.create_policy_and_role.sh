#!/bin/bash

# copy policy to vault pod
kubectl cp ./nginx_policy.hcl vault-0:/tmp/nginx_policy.hcl 

# create policy
kubectl exec vault-0 -- vault policy write nginx_policy /tmp/nginx_policy.hcl

# create role
kubectl exec vault-0 -- vault write auth/kubernetes/role/nginx \
     bound_service_account_names=nginx \
     bound_service_account_namespaces=default \
     policies=nginx_policy \
     ttl=24h
