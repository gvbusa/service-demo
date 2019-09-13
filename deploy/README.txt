Deploy application to a Kubernetes Cluster

How to use:
From the project root folder ./deploy/bin/run.sh <ACTION> <TARGET_ENV> <VERSION>
e.g. ./deploy/bin/run.sh deploy dev 1.0

How to setup the deploy folder:
deploy/bin - scripts
config/dev, /prd, etc. - application.properties and deploy.properties
helmchart - templates, Chart.yaml, values.yaml.tpl
README.txt - this file

