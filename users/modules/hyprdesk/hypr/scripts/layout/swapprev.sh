#!/usr/bin/env bash

# THIS SCRIPT IS SENSIBLE TO TOP/BOTTOM GAP size find fix.
# hyprctl getoption general:gaps_in
# hyprctl getoption general:gaps_out
# hyprctl getoption general:border_size
win=$(hyprctl activewindow -j)
ws_id=$(echo "$win" | jq '.workspace.id');
ws_layout=$(hyprctl workspaces -j | jq -r "map(select(.id == $ws_id))[0].tiledLayout")

swap_prev() {
	w_at=$(echo "$win" | jq ".at[1]");
	w_s=$(echo "$win" | jq ".size[1]");

	if [[ "$w_at" == 1 ]]; then
		if [[ "$w_s" -lt 1050 ]]; then
			hyprctl dispatch layoutmsg "movewindow l";
			hyprctl dispatch layoutmsg "promote";
		else
			hyprctl dispatch layoutmsg "movewindow l";
		fi
	else
		hyprctl dispatch layoutmsg "movewindow u";
	fi
}

case "$ws_layout" in 
	"master") hyprctl dispatch layoutmsg "swapprev";;
	"scrolling") swap_prev;;
	*) hyprctl notify 3 4000 0 "No $ws_layout layout message for cycleprev.";;
esac
