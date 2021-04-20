#!/bin/bash

echo "Call kubernetes deploy.sh with: $1"
export ENV="$1"

if [[ "$ENV" == "local" ]]; then
  echo "Skip this step becasue not running kubernetes on localhost"
  exit 1
elif [[ "$ENV" == "dev" || "$ENV" == "test" ]]; then
  echo "Set context to dev-user@dev-cluster"
  eval "kubectl config use-context $ENV-user@$ENV-cluster"
elif [[ "$ENV" == "prod" ]]; then
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
fi

echo ""
echo "Create cleint api deployment"
envsubst < deployment.yaml | kubectl apply -f -

echo ""
echo "Create demo service"
kubectl apply -f service.yaml

echo ""
echo "Create demo prometheus metrics"
kubectl apply -f prometheus.yaml

echo ""
echo "Rollout demo deployment"
kubectl rollout restart deployment demo
