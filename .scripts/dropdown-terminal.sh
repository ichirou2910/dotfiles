#!/bin/bash

. "${HOME}/.ik_var"

noterr() {
	notify-send.py -u low -r 18 -a "System" "Install tdrop" "<i>yay -S tdrop-git</i>"
	exit 1
}
type -p "tdrop" &>/dev/null || noterr

tdrop -ma -w 50% -h 35% -y 50 -x 25% -s dropdown kitty
