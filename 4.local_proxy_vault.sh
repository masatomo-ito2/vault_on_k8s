#!/bin/bash

set -x

# After this, you can access Vault (including UI) at http://localhost:8200
kubectl port-forward vault-0 8200:8200 
