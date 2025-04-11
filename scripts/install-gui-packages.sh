#!/bin/bash 
set -e
echo "Updating package list..."
sudo apt update

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y wget gpg apt-transport-https software-properties-common

# ## install vscode and slack 
sudo snap install --classic code slack obsidian


# docker set up
# get sources
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
