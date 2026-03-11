#!/usr/bin/env bash
mon=$(hyprctl monitors -j)

while read -r m_id; do
	for ws_id in $(seq $((m_id * 10)) $((m_id * 10 + 9))) ; do
		hyprctl keyword workspace "$ws_id, monitor:$m_id"
	done 
done < <(jq -r '.[].id' <<< "$mon")
