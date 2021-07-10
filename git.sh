#!/bin/bash


if [[ -z $NAME ]]; then
  echo "Missing project name"
  exit 1
fi

while read line; do
    export $line
done < secret.properties

gh repo create "$NAME" --private --confirm

gh repo clone "$NAME"
cd "$NAME" || exit 1

gh secret set JENKINS_URL  -b"${JENKINS_URL}"
gh secret set JENKINS_USER  -b"${JENKINS_USER}"
gh secret set JENKINS_TOKEN  -b"${JENKINS_TOKEN}"


