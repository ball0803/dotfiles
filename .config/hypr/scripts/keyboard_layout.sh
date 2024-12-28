#!/bin/bash

map_active_keymap_to_layout() {
	local active_name="$1"

	declare -A keymap_translation=(
		["English (programmer Dvorak)"]="English (US, Dvp)"
		["French (AZERTY)"]="French (FR, AZERTY)"
		# Add more mappings as needed
	)

	# If a matching key exists in the map, return the corresponding layout
	if [[ ${keymap_translation[$active_name]+_} ]]; then
		echo "${keymap_translation[$active_name]}"
	else
		echo "$active_name" # If no mapping exists, return the original
	fi
}

# Function to extract full layout names from layout files
get_full_layout_name() {
	layout_file="/usr/share/X11/xkb/symbols/$1"
	full_name=$(grep -m 1 -oP 'name\[Group1\]\s*=\s*"\K[^"]+' "$layout_file")
	if [[ -n "$2" ]]; then
		variant=$(echo "${2^}")
		full_name="${full_name%)}, $variant)"
	fi
	echo "$full_name"
}

# Initialize index variable
index=0

# Initialize array to store full layout names
layout_names=()
layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .layout')
variant=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .variant')

# Separate layout and variant into arrays
IFS=',' read -ra layout_elements <<<"$layout"
IFS=',' read -ra variant_elements <<<"$variant"

# Loop through the elements and combine layout and variant
for ((i = 0; i < ${#layout_elements[@]}; ++i)); do
	# Trim leading/trailing whitespace
	layout=$(echo "${layout_elements[$i]}" | tr -d '[:space:]')
	variant=$(echo "${variant_elements[$i]}" | tr -d '[:space:]')
	# Print layout and variant combined with comma
	full_name=$(get_full_layout_name "$layout" "$variant")
	layout_names+=("$full_name")
done
hyprctl switchxkblayout at-translated-set-2-keyboard next
hyprctl switchxkblayout sino-wealth-gaming-kb- next

active_keymap="$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .active_keymap')"
normalized_keymap=$(map_active_keymap_to_layout "$active_keymap")
notify-send "Active Keymap" "$normalized_keymap"

echo "Active = $normalized_keymap"
# Print the layout names array
# printf "%s\n" "${layout_names[@]}"

# Use rofi -dmenu to display layout names and get user selection
selected_layout=$(printf "%s\n" "${layout_names[@]}" | rofi -dmenu -replace -select "${normalized_keymap}" -config "$HOME/.config/rofi/config-layout-switch.rasi")

# Find the index of the selected layout in the array
selected_index=0

for name in "${layout_names[@]}"; do
	if [[ "$name" == "$selected_layout" ]]; then
		hyprctl switchxkblayout at-translated-set-2-keyboard $selected_index
		hyprctl switchxkblayout sino-wealth-gaming-kb- $selected_index
		notify-send "Active Keymap" "$name"
		exit 0
	fi
	((selected_index++))
done

# If the selected layout is not found, echo -1 (error)
# echo "-1"
