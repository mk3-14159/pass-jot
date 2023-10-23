#!/usr/bin/env bash

# Copyright (C) 2023 MK Chong. All Rights Reserved.
# This file is licensed under the MIT. Please see LICENSE for more information.

# Setting up env variables
umask "${JOT_UMASK:-077}"
set -o pipefail

# Timestamp variables 
TIME=$(date "+%H:%M:%S")
DATE=$(date +"%A, %d %B %Y")

# Tree Constants 
JOURNAL_FILE="$HOME/.jot/jot.log"
BRANCH="  │"
TIME_STAMP_PAST="  ├──"
TIME_STAMP_CURRENT="  └──"
CONTINUE_BRANCH="  │   └──"
END_BRANCH="      └──"

#
# BEGIN platform definable
#

verify_current_date() {
    latest_date=$(grep -oE '[A-Za-z]+, [0-9]+ [A-Za-z]+ [0-9]{4}' journal.txt | tail -1)
}

#
# END platform definable
#


#
# BEGIN subcommand functions
#

# Check Version
cmd_version() {
	cat <<-_EOF
    +-----------------------------------+
    | jot: a timestamped thought logger |
    |                                   |
    |             v0.0.1                |
    |                                   |
    |             Mk Chong              |
    |            mkchong.com            |
    |                                   |
    |         http://jotcli.org         |
    +-----------------------------------+
	_EOF
}

# Create new entry 
cmd_new_entry() {
    echo -e "$DATE"
    echo -e "$BRANCH"
    echo -e "$TIME_STAMP_CURRENT $TIME"
    echo -e "$END_BRANCH this is my message"
}

#
# END subcommand functions
#





