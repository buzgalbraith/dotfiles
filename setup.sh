#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y wget gpg apt-transport-https software-properties-common

## pyenv setup 
sudo apt update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt-get install -y python3-pip
curl -fsSL https://pyenv.run | bash

## install hatch and poetry for python virtualization 
python3 -m pip install poetry hatch 

# ## install vscode and slack 
sudo snap install --classic code slack obsidian

# ## setup symlinks 
DOTFILES_DIR=$(pwd)
TARGET_DIR=$HOME

declare -A FILES_TO_SYMLINK=(
    [".bashrc"]=".bashrc"
    [".gitconfig"]=".gitconfig"
    [".Xmodmap"]=".Xmodmap"
    ["vscode/keybindings.json"]=".config/Code/User/keybindings.json"
)

# Create symlinks
for SRC in "${!FILES_TO_SYMLINK[@]}"; do
    DEST="${FILES_TO_SYMLINK[$SRC]}"
    DEST_PATH="$TARGET_DIR/$DEST"
    SRC_PATH="$DOTFILES_DIR/$SRC"

    # Create the parent directory if it doesn't exist
    mkdir -p "$(dirname "$DEST_PATH")"

    # Remove existing file/symlink if it exists
    if [ -e "$DEST_PATH" ] || [ -L "$DEST_PATH" ]; then
        echo "Removing existing file: $DEST_PATH"
        rm -rf "$DEST_PATH"
    fi

    # Create symlink
    ln -s "$SRC_PATH" "$DEST_PATH"
    echo "Linked $SRC_PATH → $DEST_PATH"
done

## append keyboard swaps at boot
export CMD="@reboot bash -c 'sleep 15 && export DISPLAY=:1 && /usr/bin/xmodmap $HOME/.Xmodmap >> $HOME/xmodmap.log 2>&1'"
(crontab -l; echo $CMD) | crontab -

# docker set up
# aget sources
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
## install docker desktop
curl "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb" --output ${DOWNLOAD_DIR}/docker.deb
sudo apt install -y ${DOWNLOAD_DIR}/docker.deb
rm -f ${DOWNLOAD_DIR}/docker.deb


