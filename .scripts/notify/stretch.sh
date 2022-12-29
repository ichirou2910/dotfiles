#!/usr/bin/env bash
source $HOME/.ik_var

$EXNOTIFY_SEND "Quick Event" "Hey, stretch yourself a bit." \
	--hint string:image-path:"file://$HOME/.icons/clock.png"
