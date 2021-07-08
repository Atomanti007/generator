#!/bin/bash

export NAME=demo
export VERSION=1.0.0
export PACKAGE=hu.kzsolt
export DB_NAME=demo

ROOT_PATH=$(pwd)

export OUTPUT="."
#export OUTPUT="./generated"
export TEMPLATE_PATH="$HOME/generator/template"
#export TEMPLATE_PATH="./template/java/spring-boot"


select lang in "Java - Spring Boot" "Angular"
do
  case $lang in
  "Java - Spring Boot")
  echo "Selected language: $lang."
  break
  ;;
  "Angular")
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


if [[ $lang == 'Java - Spring Boot' ]]; then

  read -e -p "Please enter package [$PACKAGE]: " input
  export PACKAGE="${input:-$PACKAGE}"

  read -e -p "Please enter db name [$DB_NAME]: " input
  export DB_NAME="${input:-$DB_NAME}"

  ~/generator/java_spring.sh
  ~/generator/db.sh
  ~/generator/kubernetes.sh
fi

if [[ $lang == 'Angular' ]]; then
  ~/generator/angular.sh
fi


