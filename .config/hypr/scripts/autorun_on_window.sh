#!/bin/bash

function handle {
  if [[ ${1:0:10} == "openwindow" ]] && [[ $1 == *"spotify"* ]]; then
    spicetify watch -s
  fi
}

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
