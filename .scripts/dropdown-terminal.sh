#!/bin/bash

. "${HOME}/.ik_var"

noterr() {
	$EXNOTIFY_SEND -u low -r 18 -a "System" "Install tdrop" "<i>yay -S tdrop-git</i>"
	exit 1
}
type -p "tdrop" &>/dev/null || noterr

tdrop -P 'wmctrl -i -r $wid -b add,above' -ma -w "$DROPDOWN_TERM_WIDTH" -h "$DROPDOWN_TERM_HEIGHT" -y 50 -x 25% kitty
