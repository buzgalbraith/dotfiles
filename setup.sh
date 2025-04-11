#!/bin/bash
# TODO: need to add installing programs and setting up symlinks 

## append keyboard swaps at boot
export CMD="@reboot bash -c 'sleep 15 && export DISPLAY=:1 && /usr/bin/xmodmap $HOME/.Xmodmap >> $HOME/xmodmap.log 2>&1'"
(crontab -l; echo $CMD) | crontab -