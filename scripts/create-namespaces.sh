#!/bin/bash
set -e

for ns in dev qa stage prod; do
  kubectl get namespace $ns >/dev/null 2>&1 || kubectl create namespace $ns
done

echo "Namespaces created: dev, qa, stage, prod" 