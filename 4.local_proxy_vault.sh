#!/bin/bash

#if [ $# -ne 0 ]
#	then
#		echo 'Needs to supply argument'
#		echo '  $1 = <arg>'
#		exit 1
#fi

# After this, you can access Vault (including UI) at http://localhost:8200
kubectl port-forward vault-0 8200:8200 
