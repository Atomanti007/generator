#!/bin/bash

ENV="local"

if [ -z "$1" ]; then
  read -e -p "Please enter deployment tier [$ENV]: " input
  ENV="${input:-$ENV}"
else 
	ENV=$1
fi

echo "Account service will deploy to $ENV"

if [[ "$ENV" == "local" ]]; then
  echo "Start local deploy"
elif [[ "$ENV" == "dev" ]]; then
  echo "Start dev deploy"
elif [[ "$ENV" == "test" ]]; then
  echo "Start test deploy"
elif [[ "$ENV" == "prod" ]]; then
  read -p "Do you wish to deploy to PROD (y/n)? " choice
  case "$choice" in
  y | Y) ;;
  n | N) exit 1 ;;
  *) exit 1 ;;
  esac
else
  echo "Unknown ENV value: $ENV"
fi

echo ""
echo "Set gradle wrapper version 6.8n"
gradle wrapper --gradle-version 6.8 --distribution-type bin

echo ""
echo "Gradle clean"
./gradlew clean

echo ""
echo "Gradle build"
./gradlew build

echo ""
echo "Gradle publish to maven local"
./gradlew publishToMavenLocal

echo ""
echo "Gradle push docker image"
if [[ "$ENV" == "local" ]]; then
  echo "Skip docker images push because ENV=$ENV"
else
  ./gradlew pushDockerImage
fi

echo ""
echo "Deploy liquibase to $ENV"
cd liquibase
./deploy.sh "$ENV"
cd ..

echo ""
echo "Deploy to kubernetes"
cd kubernetes
./deploy.sh "$ENV"
