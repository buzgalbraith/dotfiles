#!/bin/bash
set -e
## append keyboard swaps at boot
export CMD="bash -c 'sleep 30 && export DISPLAY=:1 && /usr/bin/xmodmap $HOME/.Xmodmap >> $HOME/xmodmap.log 2>&1'"
(crontab -l; echo $CMD) | crontab -