#!/run/current-system/sw/bin/bash

spaces (){
    wmctrl -d | awk '{ printf "{ \"id\": "$1", "} { printf "\"focused\": " } { if ($2 == "*") printf "true }"; else printf "false }" }' | jq --slurp
}

spaces
