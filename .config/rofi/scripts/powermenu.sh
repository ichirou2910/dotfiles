#!/usr/bin/env bash
source $HOME/.ik_var

rofi_command="rofi -theme themes/sidebar/three.rasi"

# Options
shutdown=""
reboot=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
$shutdown)
	$ROFI_DIR/scripts/promptmenu.sh --yes-command "poweroff" --query "     Poweroff?"
	;;
$reboot)
	$ROFI_DIR/scripts/promptmenu.sh --yes-command "reboot" --query "      Reboot?"
	;;
$logout)
	$ROFI_DIR/scripts/promptmenu.sh --yes-command "pkill -KILL -u $(whoami)" --query "      Logout?"
	;;
esac
