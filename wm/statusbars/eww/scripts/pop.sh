#!/run/current-system/sw/bin/bash

calendar() {
    LOCK_FILE="$HOME/.cache/eww-calendar.lock"

    run() {
        eww open calendar
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE" ]]; then
        eww close system music_win audio_ctl
        touch "$LOCK_FILE"
        run && echo "ok good!"
    else
        eww close calendar
        rm "$LOCK_FILE" && echo "closed"
    fi
}

system() {
    LOCK_FILE="$HOME/.cache/eww-system.lock"

    run() {
        eww open system
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE" ]]; then
        eww close calendar music_win audio_ctl
        touch "$LOCK_FILE"
        run && echo "ok good!"
    else
        eww close system
        rm "$LOCK_FILE" && echo "closed"
    fi
}


music() {
    LOCK_FILE="$HOME/.cache/eww-music.lock"

    run() {
        eww open music
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE" ]]; then
        eww close calendar system audio_ctl
        touch "$LOCK_FILE"
        run && echo "ok good!"
    else
        eww close music
        rm "$LOCK_FILE" && echo "closed"
    fi
}

audio() {
    LOCK_FILE="$HOME/.cache/eww-audio.lock"

    run() {
        eww open audio_ctl
    }

    # Open widgets
    if [[ ! -f "$LOCK_FILE" ]]; then
        eww close calendar system music
        touch "$LOCK_FILE"
        run && echo "ok good!"
    else
        eww close audio_ctl
        rm "$LOCK_FILE" && echo "closed"
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
