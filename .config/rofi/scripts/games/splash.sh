#!/bin/bash
source $HOME/.ik_var

# Wrapper script to open the game splash menu for a given appid

HEIGHT=360 # This should match height in game-splash-menu.rasi

PLAY=""
OPTIONS=""
LIBRARY=""
ACHIEVEMENTS=""
NEWS=""

APPID=$1

list-icons() {
	echo $PLAY Play
	echo $LIBRARY Open in library
	echo $ACHIEVEMENTS Achievements
	echo $NEWS News
}

# See https://developer.valvesoftware.com/wiki/Steam_browser_protocol
# for a list of all commands that can be sent to Steam

handle-option() {
	case $1 in
		"$PLAY") steam steam://rungameid/$APPID ;;
		"$LIBRARY") steam steam://nav/games/details/$APPID ;;
		"$ACHIEVEMENTS") steam steam://url/SteamIDAchievementsPage/$APPID ;;
		"$NEWS") steam steam://appnews/$APPID ;;
	esac
}

# Get monitor width
# TODO: Handle case of multimonitor setups with monitors of different widths
# Currently, this just returns the width of the widest connected monitor
get-display-width() {
	xrandr | grep -e " connected " |
		grep -oP "[[:digit:]]+(?=x[[:digit:]]+)" |
		sort -nr | head -n 1
}

$ROFI_SCRIPT_DIR/games/update-banner.sh -w $(get-display-width) -h $HEIGHT -a $APPID
SELECTION="$(list-icons | rofi -dmenu -theme themes/games/splash)"
handle-option $SELECTION &
