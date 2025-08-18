#!/bin/bash
## method for clearing vim swap files
cswp() {
    local files=()
    mapfile -t files < <(find . -type f -name "*.sw[klmnop]")

    if (( ${#files[@]} )); then
        echo "Found the following swap files:"
        printf '%s\n' "${files[@]}"
        printf -- '-%.0s' {1..100}; printf '\n'
        read -r -p "Would you like to remove them (y/n): " remove
        if [[ "$remove" == "n" || "$remove" == "N" ]]; then
            echo "Keeping them."
        else
            echo "Removing swap files..."
            for f in "${files[@]}"; do
                rm -v -- "$f"
            done
        fi
    else
        echo "No swap files found in $(pwd)"
    fi
}
## method for activating python virtual environments
function act() {
    local path
    local output
        if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "Deactivating current virtual environment: $VIRTUAL_ENV"
        deactivate
    fi
    output=$(python3 ~/.methods/python_methods/act.py)
    echo $output
    path=$(echo "$output" | tail -n1 | awk '{print $NF}')  # get last word
    if [ -e "$path" ]; then
        source "$path"
    fi
}
## short cut for adding to known hosts 
function ssh_add(){
	INPUT=$1
	CUSTOM_ALIAS=$2
	IDENTITY_FILE=${3:-~/.ssh/id_rsa}

	if [[ -z "$INPUT" ]]; then
	    echo "Usage: $0 user@hostname"
	    exit 1
	fi

	USER=$(echo "$INPUT" | cut -d@ -f1)
	HOST=$(echo "$INPUT" | cut -d@ -f2)
	SHORT_HOST=${CUSTOM_ALIAS:-$(echo "$HOST" | cut -d. -f1)}

	if grep -q "Host $SHORT_HOST" ~/.ssh/config; then
	    echo "Host $SHORT_HOST already exists in SSH config."
	else
	    echo "Copying SSH key to $INPUT..."
	    ssh-copy-id -i "${IDENTITY_FILE}.pub" "$INPUT"
	    echo "Adding $SHORT_HOST to SSH config..."
	    cat <<EOF >> ~/.ssh/config


Host $SHORT_HOST
	HostName $HOST
	User $USER
	IdentityFile $IDENTITY_FILE
	ForwardAgent yes
	StrictHostKeyChecking no
EOF
		    echo "Added SSH config entry for $SHORT_HOST"
	fi
}
## function to save a full zenodo directory 
zenodo_pull() {
    local record_id="$1"
    local json_file="zenodo_record_${record_id}.json"

    # Fetch metadata
    curl -s "https://zenodo.org/api/records/${record_id}" -o "$json_file" || {
        echo "Failed to fetch metadata for record ${record_id}"
        return 1
    }

    # Extract and sanitize directory name
    local dir_name
    dir_name=$(jq -r '.metadata.title' "$json_file" | tr -cd '[:alnum:]_-' | tr ' ' '_')

    mkdir -p "$dir_name"
    # Download all files
    jq -r '.files[] | "\(.links.self) \(.key)"' "$json_file" | \
    while IFS=' ' read -r url filename; do
        echo "Downloading $filename ..."
        curl -sL "$url" -o "${dir_name}/${filename}" || echo "Failed: $filename"
    done
    rm "$json_file"
}
