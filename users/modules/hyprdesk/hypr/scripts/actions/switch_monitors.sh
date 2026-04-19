#!/usr/bin/env bash
# This script is an action. See the rofi hypr action script to run the actions and the action palette. 


# Allows to swap the right left position of screens.

sh() {
	hyprctl "$@" 1>/dev/null 2>&1;
}

monitors=$(hyprctl monitors -j)

# More than two monitors not handled. 
[[ $(echo "$monitors" | jq 'length') -ne 2 ]] && exit 1 

current=$(echo "$monitors" | jq "map(select(.focused)) | first .id")

mname() {
    jq -r "map(select(.id == $1)) | first .name" <<< "$monitors"
}

mw() {
    jq -r "map(select(.id == $1)) | first .width" <<< "$monitors"
}

mx() {
    jq -r "map(select(.id == $1)) | first .x" <<< "$monitors"
}


# Find out wich monitor is at x = 0.
matz_id=$(echo "$monitors" | jq "min_by(.x) | .id")

# Check if we found the monitor at zero.
[[ ${matz_id:-"unset"} == "unset" ]] && exit 2

new_matz_id=$(echo "$monitors" | jq "map(select(.id != $matz_id)) | first .id");


# Switch the screens around.
sh keyword monitor "$(mname "$new_matz_id")",preferred,0x0,1 ;
sh keyword monitor "$(mname "$matz_id")",preferred,"$(mw "$new_matz_id")"x0,1

sh dispatch focusmonitor "$current"
