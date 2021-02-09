#!/bin/bash

set -x 

KUBERNETES_PORT_443_TCP_ADDR=$(kubectl exec vault-0 -- printenv KUBERNETES_PORT_443_TCP_ADDR)
SERVICEACCOUNT_TOKEN=$(kubectl exec vault-0 -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)

kubectl exec vault-0 -- vault write auth/kubernetes/config \
    token_reviewer_jwt="$SERVICEACCOUNT_TOKEN" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt



