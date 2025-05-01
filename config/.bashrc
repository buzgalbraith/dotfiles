# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias hatch="python3 -m hatch"
alias poetry="python3 -m poetry"

# add spec path 
module load python/3.8.1
export SPACK_ROOT=/home/w.galbraith/spack
. $SPACK_ROOT/share/spack/setup-env.sh

# this is for vim setup
module load vim/8.2.1999
