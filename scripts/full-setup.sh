#!/bin/bash
set -e


## setup symlinks 
bash scripts/make-symlinks.sh

## setup vim
bash scripts/vim-setup.py
