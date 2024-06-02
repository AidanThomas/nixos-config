#!/run/current-system/sw/bin/bash

hyprctl monitors -j | jq '.[] | select(.focused) |.activeWorkspace.id'

socat -u UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | 
    stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'