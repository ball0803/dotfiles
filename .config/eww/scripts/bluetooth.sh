#!/bin/bash

name=$(bluetoothctl devices Connected | awk '{print $3}')
mac_addr=$(bluetoothctl devices Connected | awk '{print $2}')
status=$(bluetoothctl show | grep -q "Powered: yes" && echo "On" || echo "Off")
battery=$(bluetoothctl devices Connected | awk '{print $2}' | xargs -I{} bluetoothctl info {} | grep Battery | grep -oP '\(\K\d+(?=\))')

eww update bluetooth_status="${status}"
printf '{"name":"%s", "battery":"%s"}\n' "${name}" "${battery}"
