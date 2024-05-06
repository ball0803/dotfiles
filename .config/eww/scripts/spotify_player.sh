
#!/bin/bash
base_dir="$HOME/.config/eww/"
path=$HOME/.cache/current_art
playerctl metadata --player="spotify" -F -f '{{playerName}} {{title}} {{artist}} {{mpris:artUrl}} {{status}} {{mpris:length}}' | while read -r line; do
    title=$(playerctl metadata --player="spotify" -f "{{xesam:title}}")
    artist=$(playerctl metadata --player="spotify" -f "{{xesam:artist}}")
    artUrl=$(playerctl metadata --player="spotify" -f "{{mpris:artUrl}}")
    length=$(playerctl metadata --player="spotify" -f "{{mpris:length}}")
    if [[ $length != "" ]]; then
        length=$(($length / 1000000))
        length=$(echo "($length + 0.5) / 1" | bc)
    fi
    # Delete the image for the current song
    # Download the album art for the current song as "image.jpg"

    if [ -f "$path" ]; then
      current_art=$(cat "$path")
    fi

    if [ "$artUrl" != "$current_art" ]; then
      echo "$artUrl" > $HOME/.cache/current_art
      wget2 -q -O "${base_dir}image.jpg" "$artUrl"
      python scripts/export_template.py -image "$HOME/.config/eww/image.jpg" -cache-dir "$HOME/.cache/wal/spotify/" -template "colors-spotify.scss"
      eww reload
    fi
    lengthStr=$(playerctl --player="spotify" metadata -f "{{duration(mpris:length)}}")

    JSON_STRING=$( jq -n \
                --arg name "$name" \
                --arg title "$title" \
                --arg artist "$artist" \
                --arg artUrl "${base_dir}image.jpg" \
                --arg status "$status" \
                --arg length "$length" \
                --arg lengthStr "$lengthStr" \
                '{title: $title, artist: $artist, artUrl: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}' )
    echo $JSON_STRING
done

