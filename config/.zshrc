# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# Append history instead of overwriting
setopt APPEND_HISTORY
setopt SHARE_HISTORY           # share history across sessions
setopt INC_APPEND_HISTORY      # append as soon as a command is executed
setopt HIST_IGNORE_ALL_DUPS    # ignore duplicate commands
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir

# enable color support of ls and also add handy aliases
autoload -Uz colors && colors

# Define prompt (ps1 equivelent)
PROMPT='%F{green}%n%F{blue}@%F{green}%m%F{blue}:%F{green}%~%F{red}>%F{yellow}>%F{blue}>%f'

alias ls='ls -G'
alias tree='tree -C'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
autoload -Uz compinit
compinit

## adding shortened alias for git
alias g="git"
## adding an alias for starting docker desktop deamon 
alias ds="open -a Docker"

## setting edditor 
export EDITOR=/usr/bin/vim
## add go to path 
export PATH=$PATH:/usr/local/go/bin
export GOPATH=${HOME}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

## adding conda home to path
export conda_home=/opt/homebrew/Caskroom/miniconda/base
# add cuda to path
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export PATH=$PATH:$CUDA_HOME/bin
# add llama cpp to path
export PATH=$PATH:/home/buzgalbraith/workspace/self_host/llama.cpp/build/bin

## add the black from base env as cmd
alias black='/Users/buzgalbraith/.base_env/bin/black'


## adds optional private library dependencies ##
if [ -d /Users/buzgalbraith/.python_path_modules ]; then
    for dir in $(find /Users/buzgalbraith/.python_path_modules/ -d -maxdepth 1 -mindepth 1)     # list directories in the form "/tmp/dirname/"
    do
        dir=${dir%*/}      # remove the trailing "/"
        export PYTHONPATH=${dir}:${PYTHONPATH}
    done

fi


## get credentials token etc from private file 
if [ -f ~/.creds ]; then
    . ~/.creds
fi

## source file with helper methods 
source ~/.methods/methods.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
