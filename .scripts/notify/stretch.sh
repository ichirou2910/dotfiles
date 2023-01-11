#!/usr/bin/env bash

export DISPLAY=:0
PID=$(pgrep openbox)
DBUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/"$PID"/environ | cut -d= -f2-)
export DBUS_SESSION_BUS_ADDRESS=$DBUS_ADDRESS

/usr/bin/notify-send.sh "Quick Event" "Hey, stretch yourself a bit." \
	--hint string:image-path:"file:///home/ichirou2910/.icons/clock.png"
