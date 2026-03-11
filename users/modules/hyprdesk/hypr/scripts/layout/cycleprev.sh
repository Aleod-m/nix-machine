#!/usr/bin/env bash

win=$(hyprctl activewindow -j)
ws_id=$(echo "$win" | jq '.workspace.id');
ws_layout=$(hyprctl workspaces -j | jq -r "map(select(.id == $ws_id))[0].tiledLayout")

scrolling_prev() {
	w_at=$(echo "$win" | jq ".at[1]");

	if [[ "$w_at" == 1 ]]; then
		hyprctl dispatch layoutmsg "focus l";
	else
		hyprctl dispatch layoutmsg "focus u";
	fi
}

case "$ws_layout" in 
	"master") hyprctl dispatch layoutmsg "cycleprev";;
	"scrolling") scrolling_prev;;
	*) hyprctl notify 3 4000 0 "No $ws_layout layout message for cycleprev.";;
esac
