#!/bin/bash

# Function to extract full layout names from layout files
get_full_layout_name() {
    layout_file="/usr/share/X11/xkb/symbols/$1"
    full_name=$(grep -m 1 -oP 'name\[Group1\]\s*=\s*"\K[^"]+' "$layout_file")
    echo "$full_name"
}

# Initialize index variable
index=0

# Initialize array to store full layout names
layout_names=()

# Iterate over the layouts, extract their full names, and add them to the array
while read -r layout; do
    full_name=$(get_full_layout_name "$layout")
    layout_names+=("$full_name")
done < <(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .layout' | tr ',' '\n')


active_keymap="$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .active_keymap')"

echo "Active = $active_keymap"
# Print the layout names array
# printf "%s\n" "${layout_names[@]}"

# Use rofi -dmenu to display layout names and get user selection
selected_layout=$(printf "%s\n" "${layout_names[@]}" | rofi -dmenu -replace -select "${active_keymap}" -config "$HOME/.config/rofi/config-layout-switch.rasi")

# Find the index of the selected layout in the array
selected_index=0

for name in "${layout_names[@]}"; do
    if [[ "$name" == "$selected_layout" ]]; then
        hyprctl switchxkblayout at-translated-set-2-keyboard $selected_index
        notify-send "Active Keymap" "$name"
        exit 0
    fi
    ((selected_index++))
done


# If the selected layout is not found, echo -1 (error)
# echo "-1"
