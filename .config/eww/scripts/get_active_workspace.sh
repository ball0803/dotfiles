#!/usr/bin/env bash

# Fetch and display the active workspace ID
hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

# Listen for events from the Hyprland socket and process workspace changes
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
	stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
