#!/usr/bin/env bash
source $HOME/.owl4ce_var

rofi_command="rofi -theme themes/sidebar/five.rasi"

# Options
shutdown="⏻"
reboot=""
lock=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $shutdown)  $ROFI_DIR/scripts/promptmenu.sh --yes-command "poweroff" --query "     Poweroff?"
    ;;
    $reboot)    $ROFI_DIR/scripts/promptmenu.sh --yes-command "reboot" --query "      Reboot?"
    ;;
    $lock)      $DEFAPPS_EXEC lockscreen
    ;;
    $logout)    $ROFI_DIR/scripts/promptmenu.sh --yes-command "pkill -KILL -u $(whoami)" --query "      Logout?"
    ;;
esac
