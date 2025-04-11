#!/bin/bash
## setup python dev environment  
set -e

## install python and pip
sudo apt update
sudo apt-get install -y python3 python3-pip

## pyenv setup 
sudo apt update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl -fsSL https://pyenv.run | bash

## install hatch and poetry for python virtualization 
python3 -m pip install poetry hatch 
