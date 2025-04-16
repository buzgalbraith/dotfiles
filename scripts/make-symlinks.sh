#!/bin/bash
## make symlinks for config files.  
set -e
DOTFILES_DIR=$(pwd)
TARGET_DIR=$HOME

declare -A FILES_TO_SYMLINK=(
    ["config/.bashrc"]=".bashrc"
    ["config/.gitconfig"]=".gitconfig"
    ["config/.Xmodmap"]=".Xmodmap"
    ["config/.tmux.conf"]=".tmux.conf"
    ["config/.vimrc"]=".vimrc"
    ["config/vscode/settings.json"]=".config/Code/User/settings.json"
    ["config/vscode/keybindings.json"]=".config/Code/User/keybindings.json"
    ["config/hatch/config.toml"]=".config/hatch/config.toml"
    ["config/pypoetry/config.toml"]=".config/pypoetry/config.toml"
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

