new_art=$(playerctl --player="spotify" metadata -f '{{mpris:artUrl}}')

path=$HOME/.cache/current_art
if [ -f "$path" ]; then
  current_art=$(cat "$path")
fi


if [ "$new_art" != "$current_art" ]; then
  curl -o $HOME/.cache/current_art.png "$new_art"
  echo "$new_art" > $HOME/.cache/current_art
  wal -s -t -n -a 70 -i $HOME/.cache/current_art.png
  eww reload
else
  echo ""
fi
