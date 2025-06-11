#!/usr/bin/env bash
# Cycle monitors in increasing id order.
m_nb=$(hyprctl monitors -j | jq 'length')
m_id=$(hyprctl monitors -j | jq 'map(select(.focused)).[0].id')
m_focus_id=$(((m_id + 1) % m_nb))
hyprctl dispatch -- focusmonitor "$m_focus_id"
