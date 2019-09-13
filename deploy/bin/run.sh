#!/usr/bin/env bash
set -x
set -a

export ACTION="$1"
export TARGET_ENV="$2"
export VERSION="$3"
export BIN_DIR=$( dirname $0 )

# process values template using jinja
source ${BIN_DIR}/../config/${TARGET_ENV}/deploy.properties
j2 ${BIN_DIR}/../helmchart/values.yaml.tpl > ${BIN_DIR}/../helmchart/values.yaml

# start local tiller
export HELM_HOST=localhost:44134
TILLER_PID=$( ps aux | grep [t]iller | awk '{print $2}' )
if [[ -z ${TILLER_PID} ]]; then
    tiller --storage=secret &
fi

# run the action
./${BIN_DIR}/${ACTION}.sh ${TARGET_ENV}
