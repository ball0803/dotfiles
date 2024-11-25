#!/bin/bash
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

# Cache file for holding the current wallpaper

cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.png" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.png\", width); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        sleep 1
        if [ -f $cache_file ]; then
            wal -q -a 70 -i $current_wallpaper
        else
            wal -q -a 70 -i ~/wallpaper/
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        sleep 0.2
        selected=$( find "$HOME/wallpaper" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$HOME/wallpaper/${rfile}\n"
        done | rofi -dmenu -i -replace -config ~/.config/rofi/config-wallpaper.rasi)
        

        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -a 70 -i ~/wallpaper/$selected
        echo "* { current-image: url(\"$HOME/wallpaper/$selected\", width); }" > "$rasi_file"
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -a 70 -i ~/wallpaper/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
# ~/.config/waybar/launch.sh
eww reload
# spicetify apply -q
systemctl --user restart dunst

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="center"
# transition_type="wipe"
transition_type="outer"
# transition_type="any"
# transition_type="random"

height=$(hyprctl monitors | awk '/availableModes:/ {split($2, modes, "x"); split(modes[2], height, "@"); print height[1]}')
while read -r x y; do
  inverted_y=$((height - y))
  position="$x, $inverted_y"
done < <(hyprctl cursorpos | awk -F ', ' '{print $1, $2}')

wallpaper_engine=$(cat $HOME/.config/.settings/wallpaper-engine.sh)
if [ "$wallpaper_engine" == "swww" ] ;then
    # swww
    echo ":: Using swww"
    swww img $wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 \
        --transition-pos "$position"
elif [ "$wallpaper_engine" == "hyprpaper" ] ;then
    # hyprpaper
    echo ":: Using hyprpaper"
    killall hyprpaper
    wal_tpl=$(cat $HOME/.config/.settings/hyprpaper.tpl)
    output=${wal_tpl//WALLPAPER/$wallpaper}
    echo "$output" > $HOME/.config/hypr/hyprpaper.conf
    hyprpaper &
else
    echo ":: Wallpaper Engine disabled"
fi

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:33 -h string:x-dunst-stack-tag:wallpaper
    sleep 2
fi

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"
