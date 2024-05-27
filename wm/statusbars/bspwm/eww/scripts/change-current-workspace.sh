#!/run/current-system/sw/bin/bash

if test "$1" = "down"
then
	bspc desktop -f prev
elif test "$1" = "up"
then
	bspc desktop -f next
fi

sleep(1)
