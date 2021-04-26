#!/bin/bash

sudo cp generate.sh /usr/local/bin/pgen

rm -rf $HOME/generator/template/*
cp -R /mnt/c/Projects/storesync.io/generator/template/* $HOME/generator/template
