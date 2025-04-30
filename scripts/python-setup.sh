#!/bin/bash
## setup python dev environment  
set -e

python3 -m pip install --upgrade --user pip

## install hatch and poetry for python virtualization 
python3 -m pip install --user poetry hatch 
