#!/bin/bash


if [[ -z $NAME ]]; then
  echo "Missing project name"
  exit 1
fi

while read line; do
    export $line
done < ~/generator/secret.properties


function git_init() {

  git init "$NAME"

  cd "$NAME" || exit 1

  gh repo create

  gh secret set JENKINS_URL -b"${JENKINS_URL}"
  gh secret set JENKINS_USER -b"${JENKINS_USER}"
  gh secret set JENKINS_TOKEN -b"${JENKINS_TOKEN}"

}

function init_commit() {

  echo 'Add submodule'
  git submodule add -b main git@github.com:Atomanti007/storesync-build.git

  echo 'Add files local repository'
  git add .

  echo 'Initial commit'
  git commit -m "Init"
  git branch -M main

  echo 'Git push'
  git push -u origin main

}


