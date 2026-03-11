#!/usr/bin/env bash

ws=$(hyprctl activeworkspace -j)
ws_layout=$(jq -r ".tiledLayout" <<< "$ws")
ws_id=$(jq -r ".id" <<< "$ws")

case "$ws_layout" in
	"master") hyprctl keyword -- workspace "$ws_id, layout:scrolling";;
	"scrolling") hyprctl keyword -- workspace "$ws_id, layout:master";;
	*) hyprctl notify 3 4000 0 "Unsupoorted $ws_layout layout.";;
esac
