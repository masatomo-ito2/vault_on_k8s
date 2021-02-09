#!/bin/bash

set -x

helm install vault hashicorp/vault --values helm-vault-values.yml 
