#!/usr/bin/env bash

export OUT=""
row () {
	OUT="$OUT$1"; shift;
    local delim='\0';
    while [ $# -ge 2 ]; do
		OUT="$OUT$delim$1\x1f$2";
        shift 2;
        delim='\x1f';
    done
	OUT="$OUT\n"
}

set_opt () {
	OUT="$OUT\0$0\x1f$1\n"
}

run_rofi() {
	case "$ROFI_RETV" in
		0) init "$@";;
		1) on_select "$@";;
		2) on_custom "$@";;
		3) init "$@";;
	esac
	echo -en "$OUT";

}

