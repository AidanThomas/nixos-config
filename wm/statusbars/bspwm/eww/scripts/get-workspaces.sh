#!/run/current-system/sw/bin/bash

spaces (){
    DESKTOPS=$(bspc query -D --names)
    OCCUPIED=$(bspc query -D -d .occupied --names)
    FOCUSED=$(bspc query -D -d .focused --names)

    IS_OCCUPIED=""
    IS_FOCUSED=""
    for i in ${DESKTOPS}; do
        if [[ $OCCUPIED == *"$i"* ]]; then
            IS_OCCUPIED="${IS_OCCUPIED} true"
        else
            IS_OCCUPIED="${IS_OCCUPIED} false"
        fi

        if [[ $FOCUSED == *"$i"* ]]; then
            IS_FOCUSED="${IS_FOCUSED} true"
        else
            IS_FOCUSED="${IS_FOCUSED} false"
        fi
    done

    DESKTOPS=(${DESKTOPS})
    IS_OCCUPIED=(${IS_OCCUPIED})
    IS_FOCUSED=(${IS_FOCUSED})

    OUTPUT=""
    for i in ${DESKTOPS[@]}; do
        OUTPUT="$OUTPUT{\"name\": ${DESKTOPS[$i-1]}, \"occupied\": ${IS_OCCUPIED[$i-1]}, \"focused\": ${IS_FOCUSED[$i-1]}}"
    done
    echo ${OUTPUT} | jq --slurp -Mc
}

spaces
bspc subscribe desktop node_transfer | while read -r _ ; do
    spaces
done
