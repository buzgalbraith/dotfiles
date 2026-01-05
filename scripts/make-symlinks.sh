#!/bin/bash
## make symlinks for config files.  
set -e
DOTFILES_DIR=$(pwd)
TARGET_DIR=$HOME

declare -A FILES_TO_SYMLINK=(
    ["config/.zshrc"]=".zshrc"
    ["config/.gitconfig"]=".gitconfig"
    ["config/.Xmodmap"]=".Xmodmap"
    ["config/.tmux.conf"]=".tmux.conf"
    ["config/.vimrc"]=".vimrc"
    ["config/vscode/settings.json"]="Library/Application Support/Code/User/settings.json"
    ["config/vscode/keybindings.json"]="Library/Application Support/Code/User/keybindings.json"
    ["config/pypoetry/config.toml"]=".config/pypoetry/config.toml"
    ["methods"]=".methods"
)

# Create symlinks
for SRC in "${!FILES_TO_SYMLINK[@]}"; do
    DEST="${FILES_TO_SYMLINK[$SRC]}"
    DEST_PATH="$TARGET_DIR/$DEST"
    SRC_PATH="$DOTFILES_DIR/$SRC"

    # Create the parent directory if it doesn't exist
    echo $DEST_PATH
    mkdir -p "$(dirname "$DEST_PATH")"

    # Remove existing file/symlink if it exists
    if [ -e "$DEST_PATH" ] || [ -L "$DEST_PATH" ]; then
        echo "Removing existing file: $DEST_PATH"
        rm -rf "$DEST_PATH"
    fi

    # Create symlink
    if [[ "$SRC" == config/vscode/* ]]; then
        ln "$SRC_PATH" "$DEST_PATH"  # hard link
        echo "Hard linked $SRC_PATH → $DEST_PATH"
    else
        ln -s "$SRC_PATH" "$DEST_PATH"  # symlink
        echo "Symlinked $SRC_PATH → $DEST_PATH"
    fi
done

