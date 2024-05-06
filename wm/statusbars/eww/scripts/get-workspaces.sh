#!/run/current-system/sw/bin/bash

spaces (){
    WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
    NUMBER=$(echo "$WORKSPACE_WINDOWS" | jq --slurp '.[] | length')
    seq 1 $NUMBER | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
}

spaces
socat -u UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces
done
