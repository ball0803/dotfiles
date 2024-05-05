#!/bin/bash

hex_to_rgb() {
    # Remove leading '#' if present
    hex_color="${1#"#"}"

    # Extract RGB components
    r_hex="${hex_color:0:2}"
    g_hex="${hex_color:2:2}"
    b_hex="${hex_color:4:2}"

    # Convert hexadecimal to decimal
    r=$((16#${r_hex}))
    g=$((16#${g_hex}))
    b=$((16#${b_hex}))

    # Output RGB values separated by commas
    echo "$r, $g, $b"
}

# Check if correct number of arguments provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <colors.ini> <template_folder> <output_folder>"
    exit 1
fi

colors_file="$1"
template_folder="$2"
output_folder="$3"

# Check if colors.ini exists
if [ ! -f "$colors_file" ]; then
    echo "Error: $colors_file not found."
    exit 1
fi

# Check if template folder exists
if [ ! -d "$template_folder" ]; then
    echo "Error: $template_folder not found."
    exit 1
fi

# Create output folder if it doesn't exist
mkdir -p "$output_folder"

# Parse colors.ini and generate color configuration
declare -A colors
while IFS='=' read -r key value; do
    key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    value_hex=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    value_rgb=$(hex_to_rgb $value_hex)
    colors["$key"]=$value
    colors["$key.rgb"]=$value_rgb
    colors["$key.strip"]="${value_hex#"#"}"
done < "$colors_file"

# Process each template file
for template_file in "$template_folder"/*; do
    if [ -f "$template_file" ]; then
        filename=$(basename -- "$template_file")
        output_file="$output_folder/${filename//TEMPLATE/}"

        # Replace placeholders with color values
        sed_cmd=""
        for key in "${!colors[@]}"; do
            sed_cmd+="s|{$key}|${colors[$key]}|g;"
        done

        # Apply sed command to template file and save to output folder
        sed -e "$sed_cmd" "$template_file" > "$output_file"
        echo "Generated: $output_file"
    fi
done

echo "Done."
