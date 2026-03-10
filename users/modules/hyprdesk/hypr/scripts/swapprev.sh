#!/usr/bin/env bash

win=$(hyprctl activewindow -j)
ws_id=$(echo "$win" | jq '.workspace.id');
ws_layout=$(hyprctl workspaces -j | jq -r "map(select(.id == $ws_id))[0].tiledLayout")

swap_prev() {
	w_at=$(echo "$win" | jq ".at[1]");

	if [[ "$w_at" == 1 ]]; then
		hyprctl dispatch layoutmsg "movewindow u";
	else
		hyprctl dispatch layoutmsg "movewindow l";
	fi
}

case "$ws_layout" in 
	"master") hyprctl dispatch layoutmsg "swapprev";;
	"scrolling") swap_prev;;
	*) hyprctl notify 3 4000 0 "No $ws_layout layout message for cycleprev.";;
esac
