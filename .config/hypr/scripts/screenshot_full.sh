#!/bin/bash

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

grim "$DIR$NAME" 
xclip -selection clipboard -t image/png -i "$DIR$NAME"
notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
swappy -f "$DIR$NAME"
