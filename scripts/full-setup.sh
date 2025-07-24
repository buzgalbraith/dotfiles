#!/bin/bash
set -e

## install command line packages 
bash scripts/install-cli-packages.sh

## setup python environment 
bash scripts/python-setup.sh

## setup gnome environment
bash scripts/gnome-setup.sh 

## setup symlinks 
bash scripts/make-symlinks.sh

## remap keys 
bash scripts/remap.sh



