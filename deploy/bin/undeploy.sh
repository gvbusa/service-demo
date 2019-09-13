#!/usr/bin/env bash
set -x
set -a

# deploy using helm
helm delete --purge ${HELM_RELEASE_NAME}
