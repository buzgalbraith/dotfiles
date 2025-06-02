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

