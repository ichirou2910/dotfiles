#!/bin/bash
source $HOME/.ik_var

$ROFI_SCRIPT_DIR/games/update-entries.sh -q &

(
	# Temporarily overwrite XDG_DATA_HOME so that Rofi looks for
	# .desktop files in $GAME_LAUNCHER/applications instead of
	# ~/.local/share/applications

	export XDG_DATA_HOME=$GAME_LAUNCHER_CACHE_DIR
	rofi -show drun -theme themes/games -drun-categories SteamLibrary \
		-cache-dir $GAME_LAUNCHER_CACHE_DIR
)
