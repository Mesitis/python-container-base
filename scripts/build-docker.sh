#!/usr/bin/env bash
# Cache the CodeArtifact token locally
set -e
mkdir -p .artifact
TOKEN_FILE=.artifact/token

find .artifact -name token -type f -mmin +720 -delete

if [ ! -f "$TOKEN_FILE" ]; then
  echo "AWS CodeArtifact token expired. Acquiring new token. Dependencies will be re-downloaded."
  aws codeartifact get-authorization-token --region ap-southeast-1 --domain canopy --domain-owner 221120163160 --query authorizationToken --output text > $TOKEN_FILE
fi

VERSION=${1:-latest}

if [[ ! -v IMAGE_TAG_PREFIX ]]; then
  POETRY_PACKAGE_VERSION=$(poetry version)
  IMAGE_TAG_PREFIX="${POETRY_PACKAGE_VERSION%% *}"
fi

echo "Building docker image with tag ${IMAGE_TAG_PREFIX}"
ARTIFACT_PASSWORD=$(cat $TOKEN_FILE)

docker build --target base -t "${IMAGE_TAG_PREFIX}:$VERSION-toolkit-base" .
docker build --target builder -t "${IMAGE_TAG_PREFIX}:$VERSION-toolkit-builder" .
docker build --target app -t "${IMAGE_TAG_PREFIX}:$VERSION-toolkit" --build-arg ARTIFACT_PASSWORD="${ARTIFACT_PASSWORD}" .

docker push "${IMAGE_TAG_PREFIX}:$VERSION-toolkit-base"
docker push "${IMAGE_TAG_PREFIX}:$VERSION-toolkit-builder"
docker push "${IMAGE_TAG_PREFIX}:$VERSION-toolkit"
