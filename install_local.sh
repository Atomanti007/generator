#!/bin/bash

sudo cp generate.sh /usr/local/bin/pgen

rm -rf $HOME/generator/template/*
cp /mnt/c/Projects/storesync.io/generator/java_spring.sh $HOME/generator/java_spring.sh
cp /mnt/c/Projects/storesync.io/generator/db.sh $HOME/generator/db.sh
cp /mnt/c/Projects/storesync.io/generator/kubernetes.sh $HOME/generator/kubernetes.sh
cp /mnt/c/Projects/storesync.io/generator/angular.sh $HOME/generator/angular.sh
cp /mnt/c/Projects/storesync.io/generator/git.sh $HOME/generator/git.sh
cp /mnt/c/Projects/storesync.io/generator/secret.properties $HOME/generator/secret.properties
cp -R /mnt/c/Projects/storesync.io/generator/template/* $HOME/generator/template
