#!/usr/bin/env bash
HYPRDESC_ACTION_DIR="$HOME/.config/hypr/scripts/actions"

row () {
    echo -en "$1"; shift;
    local delim='\0';
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

setup () {
    set_opt "prompt" "Select action";

    actions=$(ls "$HYPRDESC_ACTION_DIR");

    for action in $actions; do
        if [ ! -f "$HYPRDESC_ACTION_DIR/$action" ]; then
            continue;
        fi
        action="${action%.sh}"
        row "${action//_/ }"
    done
}

on_select () {
    local script="${1// /_}"
    bash "$HYPRDESC_ACTION_DIR/${script}.sh" 1>/dev/null 2>&1;
}

case $ROFI_RETV in
    0) setup;; 
    1) on_select "$1";;
    *) exit 0;;
esac
