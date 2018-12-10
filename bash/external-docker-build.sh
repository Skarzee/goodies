#!/bin/bash

# This takes an EXTERNAL repository, and allows us to publish it to OUR registry
# Useful for projects where there isn't the ability to use full releases, and we want to rely on master branches# saner programming env: these switches turn some bugs into errors

# Requirements:
# * git
# * docker
# * curl

# Define the repository that you want to use
# TODO: This only uses GCP right now, needs to be able to support multiple clouds
# TODO: Only supports github

# Example usage:
# bash external-docker-build.sh gocd-monitor gocd-monitor bookinggo-cloud-dev karmats/gocd-monitor

PROJECT_NAME=$1
IMAGE_NAME=$2
GCPPROJECT=$3
REPO=$4

# Use HTTPS here, prevents moresetup
echo "INFO: Creating directory for repository"
mkdir application/

echo "INFO: Cloning repository (github)"
git clone https://github.com/$REPO.git application

echo "INFO: Building Docker image..."
cd application/

# Ascertain then pull the first line so we not what to build from
BASE_IMAGE=$(grep "FROM" Dockerfile | head -n1| sed 's/FROM //g')
docker pull $BASE_IMAGE

# Pull down the current latest image
docker pull eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest

# Build from local directory, using the above download as a cache
docker build --cache-from eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest -t eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest .

# Push new image up to OUR internal repo
docker push eu.gcr.io/${GCPPROJECT}/${PROJECT_NAME}/images/${IMAGE_NAME}:latest