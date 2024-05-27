#!/run/current-system/sw/bin/bash

parse() {
  case $1 in
	  activewindowv2*) active=$(echo $line | sed 's/activewindowv2>>/0x/')
		  if [ "$active" = "$arg" ]; then echo ""; fi
		  ;;
	  urgent*) arg=$(echo $line | sed 's/urgent>>/0x/')
		  urgent=$(hyprctl clients -j | jq --arg query $arg '.[] | select(.address == $query) | .workspace.id')
		  echo $urgent
		  ;;
  esac
}

socat -U - UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do parse "$line"; done
