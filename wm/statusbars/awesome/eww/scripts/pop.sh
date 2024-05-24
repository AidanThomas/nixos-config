#!/run/current-system/sw/bin/bash
LOCK_FILE_CAL="$HOME/.cache/eww-calendar.lock"
LOCK_FILE_MEM="$HOME/.cache/eww-system.lock"
LOCK_FILE_SONG="$HOME/.cache/eww-music.lock"
LOCK_FILE_AUDIO="$HOME/.cache/eww-audio.lock"

calendar() {
    run() {
        eww open calendar
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE_CAL" ]]; then
        eww close system music_win audio_ctl
        touch "$LOCK_FILE_CAL"
        rm $LOCK_FILE_MEM
        rm $LOCK_FILE_SONG
        rm $LOCK_FILE_AUDIO
        run && echo "ok good!"
    else
        eww close calendar
        rm "$LOCK_FILE_CAL" && echo "closed"
    fi
}

system() {
    run() {
        eww open system
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE_MEM" ]]; then
        eww close calendar music_win audio_ctl
        touch "$LOCK_FILE_MEM"
        rm $LOCK_FILE_CAL
        rm $LOCK_FILE_SONG
        rm $LOCK_FILE_AUDIO
        run && echo "ok good!"
    else
        eww close system
        rm "$LOCK_FILE_MEM" && echo "closed"
    fi
}


music() {
    run() {
        eww open music_win
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE_SONG" ]]; then
        eww close calendar system audio_ctl
        touch "$LOCK_FILE_SONG"
        rm $LOCK_FILE_CAL
        rm $LOCK_FILE_MEM
        rm $LOCK_FILE_AUDIO
        run && echo "ok good!"
    else
        eww close music
        rm "$LOCK_FILE_SONG" && echo "closed"
    fi
}

audio() {
    run() {
        eww open audio_ctl
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE_AUDIO" ]]; then
        eww close calendar system music_win
        touch "$LOCK_FILE_AUDIO"
        rm $LOCK_FILE_CAL
        rm $LOCK_FILE_MEM
        rm $LOCK_FILE_SONG
        run && echo "ok good!"
    else
        eww close audio_ctl
        rm "$LOCK_FILE_AUDIO" && echo "closed"
    fi
}

if [ "$1" = "calendar" ]; then
    calendar
elif [ "$1" = "system" ]; then
    system
elif [ "$1" = "music" ]; then
    music
elif [ "$1" = "audio_ctl" ]; then
    audio
fi
