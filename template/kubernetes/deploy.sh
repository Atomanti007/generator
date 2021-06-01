#!/bin/bash

echo "Call kubernetes deploy.sh with: $1"
export ENV="$1"

if [[ "$ENV" == "local" ]]; then
  echo "Skip this step because not running kubernetes on localhost"
  exit 1
elif [[ "$ENV" == "dev" ]]; then
  TAG=develop
  echo "Set context to dev-user@dev-cluster"
  eval "kubectl config use-context $ENV-user@$ENV-cluster"
elif [[ "$ENV" == "test" ]]; then
  TAG=staging
  echo "Set context to test-user@test-cluster"
  eval "kubectl config use-context $ENV-user@$ENV-cluster"
elif [[ "$ENV" == "prod" ]]; then
  TAG=production
  read -p "Do you wish to deploy to PROD (y/n)? " choice
  case "$choice" in
  y | Y) ;;
  n | N) exit 1 ;;
  *) exit 1 ;;
  esac

  echo "Set context to $ENV-user@$ENV-cluster"
  kubectl config use-context prod-user@prod-cluster
else
  echo "Unknown ENV value: $ENV"
  exit 1
fi

read -r APP_NAME < ../.name
read -r VERSION < ../.version
TAG=$TAG-$VERSION-$(git log -1 --pretty=format:%h)

export NAMESPACE=storesync
export APP_NAME
export VERSION
export TAG

echo ""
echo "Create $APP_NAME deployment"
envsubst < deployment.yaml | kubectl apply -f -

echo ""
echo "Create $APP_NAME service"
envsubst < service.yaml | kubectl apply -f -

echo ""
echo "Create $APP_NAME prometheus metrics"
envsubst < prometheus.yaml | kubectl apply -f -

echo ""
echo "Rollout $APP_NAME deployment"
kubectl rollout restart deployment ${APP_NAME} -n ${NAMESPACE}
