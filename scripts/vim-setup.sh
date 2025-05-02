#!/bin/bash
set -e

## make dir for plugins and cd into it  
export pack_dir=~/.vim/pack/vendor/start/
echo $pack_dir
mkdir -p $pack_dir
cd $pack_dir

## install plugins 
## comentary for commending out code 
git clone https://tpope.io/vim/commentary.git

## fuzy finder 
git clone https://github.com/ctrlpvim/ctrlp.vim.git

## code finer 
git clone https://github.com/mileszs/ack.vim.git

## file explorer 
git clone https://github.com/preservim/nerdtree.git

## easy motions 
git clone https://github.com/easymotion/vim-easymotion.git

## rose pine (neovim theme)
git clone https://github.com/rose-pine/vim.git

## adding ale 
python3 -m pip install pylint --user
git clone https://github.com/dense-analysis/ale.git

## adding jedi
git clone https://github.com/davidhalter/jedi-vim.git

## adding vim-tmux navigator
git clone https://github.com/christoomey/vim-tmux-navigator.git
