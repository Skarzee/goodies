#!/bin/bash

# Set the name of the folder in Google Container Registry and the Docker image name
PROJECT_NAME=secret-service
IMAGE_NAME=vault-provisioner

# Ascertain then pull the first line so we not what to build from
BASE_IMAGE=$(grep "FROM" Dockerfile | head -n1| sed 's/FROM //g')
docker pull $BASE_IMAGE

# Pull down the current latest image
docker pull eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest

# Build from local directory, using the above download as a cache
docker build --cache-from eu.gcr.io/${GCPPROJECT}/${PPROJECT_NAME}/images/${IMAGE_NAME}:latest -t eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest .

# Push new image up
docker push eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest
