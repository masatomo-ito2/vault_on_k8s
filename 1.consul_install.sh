#!/bin/bash

set -x 

helm install consul hashicorp/consul --values helm-consul-values.yml 
