#!/usr/bin/env bash
QUTE_SESSIONS_DIR="$HOME/.local/share/qutebrowser/sessions"

# TODO: delete / rename sessions.
# Create new session.

row () {
    echo -en "$1"; shift;
    delim='\0';
    while [ $# -ge 2 ]; do
        echo -en "$delim$1\x1f$2";
        shift 2;
        delim='\x1f';
    done
    echo -en "\n";
}

set_opt () {
    echo -en "\0$0\x1f$1\n"
}

if [ "$ROFI_RETV" = 1 ]; then
    coproc qutebrowser -s session.default_name "$1" -r "$1" 1>/dev/null 2>&1;
    # echo "coproc qutebrowser -s session.default_name \"$1\" -s auto_save.session true -r \"$1\" 1>/dev/null 2>&1;"
    exit 0;
elif [ "$ROFI_RETV" = 2 ]; then
    coproc qutebrowser -s session.default_name "$1" ":w" 1>/dev/null 2>&1;
fi

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
