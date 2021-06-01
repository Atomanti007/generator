#!/bin/bash

export NAME=demo
export PACKAGE=hu.storesync
export VERSION=0.0.1

ROOT_PATH=$(pwd)

export OUTPUT="."
#export OUTPUT="./generated"
export TEMPLATE_PATH="$HOME/generator/template"
#export TEMPLATE_PATH="./template/java/spring-boot"

while read line; do
    export $line
done < values.properties


select lang in "Java - Spring Boot"
do
  case $lang in
  "Java - Spring Boot")
  echo "Selected language: $lang."
  break
  ;;
  *)
  echo "Invalid language."
  ;;
  esac
done

read -e -p "Please enter project name [$NAME]: " input
export NAME="${input:-$NAME}"

read -e -p "Please enter package [$PACKAGE]: " input
export PACKAGE="${input:-$PACKAGE}"


read -e -p "Please enter db name [$DB_NAME]: " input
export DB_NAME="${input:-$DB_NAME}"


if [[ $lang == 'Java - Spring Boot' ]]; then
  ~/generator/java_spring.sh
fi

~/generator/db.sh
~/generator/kubernetes.sh
