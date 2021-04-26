#!/bin/bash

export NAME=demo
export PACKAGE=hu.kzsolt.storesync
export DB_NAME=DEMO-DB
export VERSION=0.0.1

ROOT_PATH=$(pwd)

OUTPUT="./"
#OUTPUT="./generated"
TEMPLATE_PATH="$HOME/generator/template"
#TEMPLATE_PATH="./template/java/spring-boot/"

while read line; do
    export $line
done < values.properties


select lang in "Java - Spring Boot"
do
  case $lang in
  "Java - Spring Boot")
  echo "Selected language: $lang."
  TEMPLATE_PATH="$TEMPLATE_PATH/java/spring-boot/*"
  break
  ;;
  *)
  echo "Invalid language."
  ;;
  esac
done

read -e -p "Please enter project name [$NAME]: " input
NAME="${input:-$NAME}"

read -e -p "Please enter package [$PACKAGE]: " input
PACKAGE="${input:-$PACKAGE}"
PACKAGE=$PACKAGE.$(echo $NAME | sed "s/-/./")
echo $PACKAGE


read -e -p "Please enter db name [$DB_NAME]: " input
DB_NAME="${input:-$DB_NAME}"


cp -R $TEMPLATE_PATH $OUTPUT


find $OUTPUT -print0 | while IFS= read -r -d '' file
do
  if [ ! -d $file ] && [ ! ${file: -4} == ".jar" ];
  then
    echo $file
    cat $file | mo > $file
  fi
done
