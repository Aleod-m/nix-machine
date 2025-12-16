#!/usr/bin/env bash

# On monitor disconnect merge the workspaces.
ws=$(hyprctl workspaces -j);
mon=$(hyprctl monitors all -j);

clients_in_ws() {
    hyprctl clients -j | jq -r "map(select(.workspace.id == $1)).[].address"
}

mon_disabled() {
    echo "$mon" | jq -r "map(select(.id == $1)) | first .disabled"
}

while read -r wsid; do
    mon_id=$(( (wsid - 1) / 10 ))
    echo "$wsid , $mon_id"
	disabled=$(mon_disabled "$mon_id")
    if [[ $disabled == "true" || $disabled == "null" ]]; then 
        new_monid=$(echo "$mon" | jq "map(select(.disabled | not)) | first .id")
        new_wsid=$((new_monid * 10 + wsid - mon_id * 10 ))
        while read -r winid; do
            hyprctl dispatch -- movetoworkspacesilent "$new_wsid",address:"$winid"
            echo "$new_wsid",address:"$winid"
        done < <(clients_in_ws "$wsid")
    fi
done < <(echo "$ws" | jq ".[].id")
