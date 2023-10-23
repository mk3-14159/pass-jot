#!/usr/bin/env bash

# Copyright (C) 2023 MK Chong. All Rights Reserved.
# This file is licensed under the MIT. Please see LICENSE for more information.

#
# BEGIN platform definitions
#

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