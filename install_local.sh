#!/bin/bash

sudo cp generate.sh /usr/local/bin/pgen

rm -rf $HOME/generator/template/*
cp /mnt/c/Projects/storesync.io/generator/java_spring.sh $HOME/generator/java_spring.sh
cp -R /mnt/c/Projects/storesync.io/generator/template/* $HOME/generator/template
