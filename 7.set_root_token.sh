#!/bin/bash

#if [ $# -ne 0 ]
#	then
#		echo 'Needs to supply argument'
#		echo '  $1 = <arg>'
#		exit 1
#fi

ROOT_TOKEN=$(cat cluster-keys.json | jq -r ".root_token")

kubectl exec vault-0 -- vault login ${ROOT_TOKEN} 

# kubectl exec vault-0 -- vault token create -id=root


