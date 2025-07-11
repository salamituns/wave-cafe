#!/bin/bash
set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <image-name> <tag>"
  echo "Example: $0 salamituns/wave-cafe 8735327"
  exit 1
fi

IMAGE_NAME=$1
TAG=$2

# Ensure buildx is set up
if ! docker buildx inspect multiarch-builder >/dev/null 2>&1; then
  docker buildx create --name multiarch-builder --use
else
  docker buildx use multiarch-builder
fi

echo "Building and pushing $IMAGE_NAME:$TAG for linux/amd64 and linux/arm64..."
docker buildx build --platform linux/amd64,linux/arm64 -t $IMAGE_NAME:$TAG --push .

echo "Done!" 