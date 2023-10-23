#!/usr/bin/env bash

# Copyright (C) 2023 MK Chong. All Rights Reserved.
# This file is licensed under the MIT. Please see LICENSE for more information.

# Setting up env variables
umask "${JOT_UMASK:-077}"
set -o pipefail

# GPG variables 
# Character variables 

#
# BEGIN platform definitions
#
JOURNAL_FILE="$HOME/.jot/jot.log"
#
# END platform definitions
#

#
# BEGIN subcommand functions
#

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

cmd_commit() {
    local MESSAGE="$1" 
    local TIMESTAMP="$(date +"%Y-%m-%d %H:%M:%S")"
    echo "[$TIMESTAMP]" >> "$JOURNAL_FILE"
    echo "Logged "
}




#
# END subcommand functions
#

PROGRAM="${0##*/}"
COMMAND="$1"

case "$1" in
	version|--version) shift;	cmd_version "$@" ;;
	*)				            cmd_extension_or_show "$@" ;;
esac
exit 0