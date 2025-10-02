#!/usr/bin/env bash

# On monitor disconnect merge the workspaces.
monitor_nb=$(hyprctl monitors -j | jq 'length')
workspaces=$(hyprctl workspaces -j | jq '.[].id')

clients_in_ws() {
    hyprctl clients -j | jq -r "map(select(.workspace.id == $1)).[].address"
}

while read -r wsid; do
    new_wsid=$(((wsid - 1) % (monitor_nb * 10) + 1))
    if [ "$new_wsid" != "$wsid" ]; then
        while read -r winid; do
            hyprctl dispatch -- movetoworkspacesilent "$new_wsid",address:"$winid"
        done < <(clients_in_ws "$wsid")
    fi
done <<< "$workspaces"
