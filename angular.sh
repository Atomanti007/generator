#!/bin/bash


echo "Start angular project generate"
ANGULAR_TEMPLATE="$TEMPLATE_PATH/angular"

if [[ -z $NAME ]]; then
  echo "Missing project name"
  exit 1
fi
if [[ -z $OUTPUT ]]; then
  echo "Missing OUTPUT dir"
  exit 1
fi
if [[ -z $TEMPLATE_PATH ]]; then
  echo "Missing template dir"
  exit 1
fi

# ------------------------------
# Init angular project
echo 'Generate angular project'
ng new "$NAME" --directory ./ --routing --style css

jq -r '.version' package.json >> .version
jq -r '.name' package.json >> .name

echo 'Add build submodule'
git submodule add -b main git@github.com:Atomanti007/storesync-build.git


echo 'Add environments'
cp "$ANGULAR_TEMPLATE/src/environments/environment.dev.ts" "$OUTPUT/src/environments/environment.dev.ts"
cp "$ANGULAR_TEMPLATE/src/environments/environment.test.ts" "$OUTPUT/src/environments/environment.test.ts"

jq ".projects.$(jq .name package.json).architect.build.configurations |= . + {dev: { fileReplacements: [{replace: \"src/environments/environment.ts\",with: \"src/environments/environment.dev.ts\" } ]}}" angular.json > tmp.json && mv tmp.json angular.json
jq ".projects.$(jq .name package.json).architect.build.configurations |= . + {test: { fileReplacements: [{replace: \"src/environments/environment.ts\",with: \"src/environments/environment.test.ts\" } ]}}" angular.json > tmp.json && mv tmp.json angular.json

echo 'Add Makefile'
cp "$ANGULAR_TEMPLATE/Makefile" "$OUTPUT/Makefile"

echo 'Add kubernetes descriptors'
KUBERNETES_TEMPLATE="$TEMPLATE_PATH/angular/kubernetes"

mkdir -p "$OUTPUT/kubernetes"
cp "$KUBERNETES_TEMPLATE/deployment.yaml" "$OUTPUT/kubernetes/deployment.yaml"
cp "$KUBERNETES_TEMPLATE/prometheus.yaml" "$OUTPUT/kubernetes/prometheus.yaml"
cp "$KUBERNETES_TEMPLATE/service.yaml" "$OUTPUT/kubernetes/service.yaml"
cp "$KUBERNETES_TEMPLATE/ingress.yaml" "$OUTPUT/kubernetes/ingress.yaml"


echo 'Add git workflows'
mkdir -p "$OUTPUT/.github/workflows"
cp "$ANGULAR_TEMPLATE/.github/workflows/build.yml" "$OUTPUT/.github/workflows/build.yml"
cp "$ANGULAR_TEMPLATE/.github/workflows/deploy-dev.yml" "$OUTPUT/.github/workflows/deploy-dev.yml"
