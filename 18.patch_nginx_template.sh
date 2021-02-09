#!/bin/bash

set -x

kubectl patch deployment nginx --patch "$(cat patch-nginx-template.yml)" 
