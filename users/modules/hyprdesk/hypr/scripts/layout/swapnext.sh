#!/usr/bin/env bash

#!/usr/bin/env bash

win=$(hyprctl activewindow -j)
ws_id=$(echo "$win" | jq '.workspace.id');
ws_layout=$(hyprctl workspaces -j | jq -r "map(select(.id == $ws_id))[0].tiledLayout")

scrolling_next() {
	w_at=$(echo "$win" | jq ".at[1]");
	w_s=$(echo "$win" | jq ".size[1]");

	if [[ "$w_at" == 1 ]]; then
		if [[ "$w_s" -lt 1050 ]]; then
			hyprctl dispatch layoutmsg "movewindow d";
		else 
			hyprctl dispatch layoutmsg "movewindow r";
		fi
	else
		if [[ $((w_at + w_s)) -gt 1050 ]]; then
			hyprctl dispatch layoutmsg "promote";
		else
			hyprctl dispatch layoutmsg "movewindow d";
		fi
	fi
}

case "$ws_layout" in 
	"master") hyprctl dispatch layoutmsg "swapnext";;
	"scrolling") scrolling_next;;
	*) hyprctl notify 3 4000 0 "No $ws_layout layout message for cyclenext.";;
esac
