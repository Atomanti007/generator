#!/bin/bash

echo "Start generate liquibase"
DB_TEMPLATE="$TEMPLATE_PATH/liquibase"

mkdir -p "$OUTPUT/liquibase"
cp -r "$DB_TEMPLATE" "$OUTPUT"
