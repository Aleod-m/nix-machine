#!/usr/bin/env bash
# This script is an action. See the rofi hypr action script to run the actions and the action palette. 

# Allows to reassign the workspaces to the right screen. Because it can get out of sync if i branch the external monitors on the usb c or the hdmi.

ws=$(hyprctl workspaces -j)
mon=$(hyprctl monitors -j)
[[ $(echo "$mon" | jq 'length') -ne 2 ]] && exit 1 

while read -r wsid; do 

    # The monitor the workspace is on.
    cmon_id=$(echo "$ws" | jq "map(select(.id == $wsid)) | first .monitorID")
    # The monitor the workspace should be on.
    nmon_id=$(((wsid-1)/10))

    hyprctl dispatch focusmonitor "$cmon_id"
    hyprctl dispatch workspace "$wsid"
    hyprctl dispatch movecurrentworkspacetomonitor "$nmon_id"
done < <(echo "$ws" | jq '.[].id')

# Restore the original workspace and monitor focused.
cws=$(echo "$mon" | jq "map(select(.focused)) | first .activeWorkspace.id")
../swk.sh "$(((cws-1)/10))"

hyprctl dispatch focusmonitor "$(echo "$mon" | jq 'map(select(.focused)) | first .id')"
