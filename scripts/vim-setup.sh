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
curl https://beyondgrep.com/ack-v3.8.1 > ~/.local/bin/ack && chmod 0755 ~/.local/bin/ack 
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

## adding vim-surround 
git clone https://github.com/tpope/vim-surround.git

## adding vim word-motion, which makes the w key work better with out messing up linting or syntax highlighting
git clone https://github.com/chaoren/vim-wordmotion.git

## adding spelunker to spell check code 
git clone https://github.com/kamykn/spelunker.vim.git

