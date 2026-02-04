#!/bin/bash
## method for clearing vim swap files
cswp() {
    local files
    files=("${(@f)$(find . -type f -name "*.sw[klmnop]")}")
    if (( ${#files[@]} )); then
        echo "Found the following swap files:"
        printf '%s\n' "${files[@]}"
        printf -- '-%.0s' {1..100}; printf '\n'
        read -r "remove?Would you like to remove them (y/n): "
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
conda_act() {

	__conda_setup="$($conda_home'/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "$conda_home/etc/profile.d/conda.sh" ]; then
		. "$conda_home/etc/profile.d/conda.sh"
	    else
		export PATH="$conda_home/bin:$PATH"
	    fi
	fi
	unset __conda_setup
}
## method for activating python virtual environments
function act() {
    echo $local_path
    local local_path
    local output
        if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "Deactivating current virtual environment: $VIRTUAL_ENV"
        deactivate
    fi
    output=$(python3 ~/.methods/python_methods/act.py)
    echo $output
    local_path=$(echo "$output" | tail -n1 | awk '{print $NF}')  # get last word
    if [ -e "$local_path" ]; then
        source "$local_path"
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

## create the base env if not already present and activate it.
base_env(){
    base_env_path=~/.base_env/
    if [ ! -e "$base_env_path" ]; then
        echo "base_env not found at $base_env_path."
        if command -v "uv" &> /dev/null; then
            echo "creating with uv"
            uv venv ~/.base_env
            source ~/.base_env/bin/activate
            uv pip install black pandas polars pylint mypy ruff
            deactivate
        elif python3 -c "import venv" 2>/dev/null; then
            echo "creating with venv"
            python3 -m venv ~/.base_env
            ~/.base_env/bin/pip install black pandas polars pylint mypy ruff
        else
            echo "please either install venv or uv."
        fi
    fi
    source ~/.base_env/bin/activate
}

# run black on a file before running git add
gab() {
    black_path=~/.base_env/bin/black
    if [ ! -e "$black_path" ]; then
        echo "black not found at $black_path."
        base_env
        deactivate
    fi     
    if [ -d "$1" ]; then
        echo "running black on directory ${1}"
        ~/.base_env/bin/black "$1"
        echo "git adding ${1}"
        git add "$1"
    elif [[ "$1" == *.py ]]; then
        echo "running black on ${1}"
        ~/.base_env/bin/black "$1"
        echo "git adding ${1}"
        git add "$1"
    else
        echo "skipping black (not a .py file), git adding ${1}"
        git add "$1"
    fi
}

## slurm helper methods for getting details about recently run jobs
sjbs() {
    local DAYS="${1:-1}"	
    echo $DAYS
    sacct --format=JobID,JobName,Partition,State,Elapsed,Start,End,NodeList,ExitCode -S $(date -d "${DAYS} days ago" +%Y-%m-%d)
}
