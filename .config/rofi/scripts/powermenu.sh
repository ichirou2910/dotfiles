#!/usr/bin/env bash
source $HOME/.ik_var

rofi_command="rofi -theme themes/sidebar/four.rasi"

# Options
shutdown=""
reboot=""
logout=""
lock=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$logout"

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
$lock)
	$ROFI_DIR/scripts/promptmenu.sh --yes-command "slock" --query "      Lock?"
	;;
esac
