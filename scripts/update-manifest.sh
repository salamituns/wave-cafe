#!/bin/bash
set -e

K8S_MANIFEST=${1:-k8s/deployment.yaml}
IMAGE_NAME=${2}
IMAGE_TAG=${3}

mkdir -p $(dirname "$K8S_MANIFEST")

if [ ! -f "$K8S_MANIFEST" ]; then
  echo "Kubernetes manifest not found, creating a default deployment.yaml."
  cat <<EOF > "$K8S_MANIFEST"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wave-cafe
spec:
  replicas: 1
  selector:
    matchLabels:
      app: wave-cafe
  template:
    metadata:
      labels:
        app: wave-cafe
    spec:
      containers:
      - name: wave-cafe
        image: ${IMAGE_NAME}:${IMAGE_TAG}
        ports:
        - containerPort: 80
EOF
else
  # Update the image tag in the manifest
  sed -i'' -e "/image:/s|image: .*|image: ${IMAGE_NAME}:${IMAGE_TAG}|" "$K8S_MANIFEST"
fi 