#!/run/current-system/sw/bin/bash

get_status() {
    STATUS=$(spotifycli --playbackstatus)
    if [[ $STATUS == *"▶"* ]]; then
        echo ""
    else
        echo ""
    fi
}

get_cover() {
    cover=`spotifycli --arturl`
    echo $cover
}

if [[ "$1" == "--song" ]]; then
    spotifycli --song
elif [[ "$1" == "--artist" ]]; then
    spotifycli --artist
elif [[ "$1" == "--status" ]]; then
	get_status
elif [[ "$1" == "--time" ]]; then
    spotifycli --position | tr -d '()'
elif [[ "$1" == "--ctime" ]]; then
    spotifycli --position | tr -d '()' | awk -F'/' '{ print $1 }'
elif [[ "$1" == "--ttime" ]]; then
    spotifycli --position | tr -d '()' | awk -F'/' '{ print $2 }'
elif [[ "$1" == "--cover" ]]; then
    get_cover
elif [[ "$1" == "--toggle" ]]; then
    spotifycli --playpause
elif [[ "$1" == "--next" ]]; then
    spotifycli --next
elif [[ "$1" == "--prev" ]]; then
    spotifycli --prev
fi
