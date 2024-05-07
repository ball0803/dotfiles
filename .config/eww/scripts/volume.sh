#!/bin/bash

# Function to extract volume and status
get_volume_status() {
    awk -F"[][]" '/Left:/ { sub("%", "", $2); printf "{\"volume\": %s, \"status\": \"%s\"}\n",$2,$4 }' <(amixer sget Master)
}

# Get initial volume status
previous_status=$(get_volume_status)

# Print initial volume and status
echo "$previous_status"

# Continuously monitor changes in volume status
pactl subscribe | rg --line-buffered "on sink" | while read -r _; do
    current_status=$(get_volume_status)
    if [ "$current_status" != "$previous_status" ]; then
        echo "$current_status"
        previous_status="$current_status"
    fi
done
