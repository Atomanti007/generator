#!/bin/bash

echo "Call liquibase deploy.sh with: $1"
ENV="$1"

if [ -z "$ENV" ]; then
  ENV=local
fi

echo "properties/$ENV/liquibase.properties"

liquibase --defaultsFile="properties/$ENV/liquibase.properties" update
