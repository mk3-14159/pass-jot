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
