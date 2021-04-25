#!/bin/bash

export NAME=demo
export PACKAGE=hu.kzsolt.storesync
export DB_NAME=DEMO-DB
export VERSION=0.0.1

ROOT_PATH=$(pwd)
OUTPUT="./"
#OUTPUT="./generated"
TEMPLATE_PATH="$HOME/template/java/spring-boot/"
#TEMPLATE_PATH="./template/java/spring-boot/"

while read line; do
    export $line
done < values.properties


select lang in "Java - Spring Boot"
do
  case $lang in
  "Java - Spring Boot")
  echo "Selected language: $lang."
  TEMPLATE_PATH="./template/java/spring-boot/"
  break
  ;;
  *)
  echo "Invalid language."
  ;;
  esac
done

read -e -p "Please enter project name: " input
NAME="${input:-$NAME}"

read -e -p "Please enter package: " input
PACKAGE="${input:-$PACKAGE}"

read -e -p "Please enter deployment tier [$DB_NAME]: " input
DB_NAME="${input:-$DB_NAME}"


cp -R $TEMPLATE_PATH $OUTPUT


find ./generated -print0 | while IFS= read -r -d '' file
do
  if [ ! -d $file ] && [ ! ${file: -4} == ".jar" ];
  then
   cat $file | mo > $file
  fi
done
