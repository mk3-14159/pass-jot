#!/bin/bash

# Check for filename argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
# File to which the entry will be appended
FILE=$1
# Check if file is valid JSON (if it exists and is non-empty)
if [ -f "$FILE" ] && [ -s "$FILE" ]; then
    jq . "$FILE" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: The file already has contents, but it's not valid JSON."
        exit 1
    fi
fi
# Prompt for user message
read -p "Enter your message: " message
# Get current date and time
current_time=$(date +"%A %d-%m-%Y %H:%M:%S")
# Use jq to append to JSON file
if [ -f "$FILE" ] && [ -s "$FILE" ]; then
    # Append to existing non-empty file
    jq --arg time "$current_time" --arg msg "$message" '. + {($time): $msg}' "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
else
    # Create new file or overwrite an empty file with the entry
    echo "{ \"$current_time\": \"$message\" }" > "$FILE"
fi
echo "Entry added!"


cmd_jot() {
    [[ $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND pass-name"

	local path="${1%/}"
	check_sneaky_paths "$path"
	mkdir -p -v "$PREFIX/$(dirname -- "$path")"
	set_gpg_recipients "$(dirname -- "$path")"
	local passfile="$PREFIX/$path.gpg"
	set_git "$passfile"

	tmpdir #Defines $SECURE_TMPDIR
	local tmp_file="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"

	local action="Add"
	if [[ -f $passfile ]]; then
		$GPG -d -o "$tmp_file" "${GPG_OPTS[@]}" "$passfile" || exit 1
		action="Edit"
	fi

    ### BEGIN - Make all json edits in $tmp_file ### 
    # Check if file is valid JSON (if it exists and is non-empty)
    local time=$(date +"%A %d-%m-%Y %H:%M:%S")
    if [ -f "$tmp_file" ] && [ -s "$tmp_file" ]; then
        jq . "$tmp_file" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "Error: The entry already has contents, but it's not valid JSON."
            exit 1
        fi
    fi

    # Prompt for user message
    read -p "Enter your message: " message

    if [ -f "$tmp_file" ] && [ -s "$tmp_file" ]; then
        # Append to existing non-empty file
        # Rewrite this line 
        jq --arg time "$time" --arg msg "$message" '. + {($time): $msg}' "$tmp_file" > "${tmp_file}.tmp" && mv "${tmp_file}.tmp" "$tmp_file"
    else
        # Create new file or overwrite an empty file with the entry
        echo "{ \"$current_time\": \"$message\" }" > "$tmp_file"
    fi
    echo "[+] $time entry added!"

    ### END - Make all json edits in $tmp_file ###  

    [[ -f $tmp_file ]] || die "New message entry not saved."
	$GPG -d -o - "${GPG_OPTS[@]}" "$passfile" 2>/dev/null | diff - "$tmp_file" &>/dev/null && die "Log unchanged."
	while ! $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" "$tmp_file"; do
		yesno "GPG encryption failed. Would you like to try again?"
	done    
	git_add_file "$passfile" "$action log message for $path"
}


