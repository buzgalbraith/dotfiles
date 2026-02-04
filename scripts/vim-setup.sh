#!/bin/bash
set -e

## make dir for plugins and cd into it  
export pack_dir=~/.vim/pack/vendor/start
mkdir -p $pack_dir
cd $pack_dir


declare -A git_links=(
    ["commentary"]="https://tpope.io/vim/commentary.git" ## commentary for code commenting
    ["ctrlp.vim"]="https://github.com/ctrlpvim/ctrlp.vim.git" ## fuzzy finder
    ["ack.vim"]="https://github.com/mileszs/ack.vim.git" ## code search
    ["nerdtree"]="https://github.com/preservim/nerdtree.git" ## file explorer
    ["rose-pine"]="https://github.com/rose-pine/vim.git" ## rose-pine theme 
    ["ale"]="https://github.com/dense-analysis/ale.git" ## ale for linting 
    ["jedi-vim"]="https://github.com/davidhalter/jedi-vim.git" ## jedi for python auto completion
    ["vim-tmux"]="https://github.com/christoomey/vim-tmux-navigator.git" ## tmux integration
    ["vim-surround"]="https://github.com/tpope/vim-surround.git" ## better motions for surrounding text
    ["word-motion"]="https://github.com/chaoren/vim-wordmotion.git" ## sets the w action to respect _ and a few other quality of life changes
    ["spelunker"]="https://github.com/kamykn/spelunker.vim.git" ## better spell check, and spell check in code.
    ["vim-gitgutter"]="https://github.com/airblade/vim-gitgutter.git" ## git integration with vim, diff files while working 
)

# ## install plugins 
for plugin in "${!git_links[@]}"; do
	git_link="${git_links[$plugin]}"
	plug_path="$pack_dir/$plugin"
	if [ ! -d $plug_path ]; then 
		git clone --recursive $git_link $plug_path	
	fi
done

## install other tools that support the vim packages
## install fzf for fuzzy file finding 
if [ ! -d ~/.fzf ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi
## install ack for code searching
if [ ! -f ~/.local/bin/ack ]; then
	curl https://beyondgrep.com/ack-v3.8.1 > ~/.local/bin/ack && chmod 0755 ~/.local/bin/ack
fi

## create base environment with linters if not already present ## 
source ~/.methods/methods.sh
base_env
deactivate
