#!/bin/bash

set -x

kubectl exec vault-0 -- vault secrets enable kv 
