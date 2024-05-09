#!/run/current-system/sw/bin/bash

amixer sget Master | awk -F '[^0-9]+' '/Left:/{print $3}'
