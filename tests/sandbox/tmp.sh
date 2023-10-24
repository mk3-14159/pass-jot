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


cmd_insert_jot() {
	local opts force=0 noecho=1 
	opts="$($GETOPT -o mef -l force,echo -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-e|--echo) noecho=0; shift ;;
		-f|--force) force=1; shift ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || ( $multiline -eq 1 && $noecho -eq 0 ) || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--echo,-e | --multiline,-m] [--force,-f] pass-name"
	local path="${1%/}"
	local passfile="$PREFIX/$path.gpg"
	check_sneaky_paths "$path"
	set_git "$passfile"

	mkdir -p -v "$PREFIX/$(dirname -- "$path")"
	set_gpg_recipients "$(dirname -- "$path")"
    tmpdir #Defines $SECURE_TMPDIR
	local tmp_file="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"

    # Don't need this as logs are overriden all the time 
	[[ $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

    local current_time=$(date +"%A %d-%m-%Y %H:%M:%S")
    local action="Add"
	if [[ -f $passfile ]]; then
		$GPG -d -o "$tmp_file" "${GPG_OPTS[@]}" "$passfile" || exit 1
		action="Edit"
	fi

    # Check if file is valid JSON (if it exists and is non-empty)
    if [ -f "$tmp_file" ] && [ -s "$tmp_file" ]; then
        jq . "$tmp_file" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "Error: The file already has contents, but it's not valid JSON."
            exit 1
        fi
    fi

    # prompt user for message 
    read -p "Enter your message: " message

    # Write JSON to tmp_file
    if [ -f "$tmp_file" ] && [ -s "$tmp_file" ]; then
        # Append to existing non-empty file
        jq --arg time "$current_time" --arg msg "$message" '. + {($time): $msg}' "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
    else
        # Create new file or overwrite an empty file with the entry
        echo "{ \"$current_time\": \"$message\" }" > "$FILE"
    fi
    echo "Entry added!"

	[[ -f $tmp_file ]] || die "New password not saved."



	git_add_file "$passfile" "$action log message for $path"
}
