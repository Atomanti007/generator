#!/bin/bash

rm -rf ./generated

ROOT_PATH=$(pwd)
OUTPUT="./generated"
TEMPLATE_PATH="./template/java/spring-boot/"

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





cp -R $TEMPLATE_PATH $OUTPUT


find ./generated -print0 | while IFS= read -r -d '' file
do
  if [ ! -d $file ] && [ ! ${file: -4} == ".jar" ];
  then
   cat $file | mo > $file
  fi
done
