#!/bin/bash 
set -e
sudo apt-get update

sudo apt-get install -y \
    vim tmux git \
    gh curl tree
## install tmux package manager as well
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
