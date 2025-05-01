#!/bin/bash
set -e

## setup python environment 
bash scripts/python-setup.sh

## setup symlinks 
bash scripts/make-symlinks.sh

## vim setup
bash scripts/vim-setup.sh
