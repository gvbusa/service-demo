#!/usr/bin/env bash
set -x
set -a

# create config map
APP_PROP_FILE=$( ls ${BIN_DIR}/../config/${TARGET_ENV}/application.* )
if [[ -n $APP_PROP_FILE  ]]; then
    kubectl create configmap ${HELM_RELEASE_NAME}-config --from-file=$APP_PROP_FILE -o yaml --dry-run > ${BIN_DIR}/../helmchart/templates/configmap.yaml
fi

# deploy using helm
helm upgrade --install ${HELM_RELEASE_NAME} ${BIN_DIR}/../helmchart

# verify
sleep 60
rollback=false

# check endpoint
hostname=$( kubectl get service service-demo-dev-service -o json | jq -r '.status.loadBalancer.ingress[0].hostname' )
port=8080
tmp_file=$( mktemp )
http_code=$( curl -s -o $tmp_file -w "%{http_code}"  http://${hostname}:${port}/hello )
if [[ "$http_code" != "200" ]]; then
    rollback=true
fi


# rollback if needed
if [[ $rollback == true ]]; then
    helm rollback ${HELM_RELEASE_NAME} 0
fi