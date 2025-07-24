#!/bin/bash 
set -e
## add repo that sets clocks on all monitors 
rm -rf ./multi-monitors-add-on
git clone git@github.com:lazanet/multi-monitors-add-on.git
mkdir -p ~/.local/share/gnome-shell/extensions
cd ./multi-monitors-add-on
rm -rf ./multi-monitors-add-on
cp -r multi-monitors-add-on@spin83 ~/.local/share/gnome-shell/extensions/