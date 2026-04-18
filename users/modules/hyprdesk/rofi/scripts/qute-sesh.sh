#!/usr/bin/env bash
#shellcheck disable=SC2120
root="$(dirname "$0")"
source "$root/helper.sh"
QUTE_SESSIONS_DIR="$HOME/.local/share/qutebrowser/sessions"

init() {
	set_opt "prompt" "Select session";

	sessions=$(ls "$QUTE_SESSIONS_DIR")
	for session_file in $sessions;  do
		if [ ! -f "$QUTE_SESSIONS_DIR/$session_file" ]; then
			continue;
		fi
		if [[ "$session_file" == _* ]]; then
			continue;
		fi
		row "${session_file%.yml}" 
	done
}

on_select() {
    coproc qutebrowser -s session.default_name "$1" -r "$1" 1>/dev/null 2>&1;
	exit 0;
}

# On custom create a new session
on_custom() {
    coproc qutebrowser -s session.default_name "$1" ":w" 1>/dev/null 2>&1;
	exit 0;
}

run_rofi "$@"
