#!/usr/bin/env bash
# shellcheck source=/dev/null
. .env

# docker login -u parrotrueper
echo "runs on host"
docker image tag "${DBG_RESULT_IMAGE:?}" "${DBG_HUB_TAG:?}:${DBG_VERSION_TAG:?}"
docker push "${DBG_HUB_TAG:?}:${DBG_VERSION_TAG:?}"
