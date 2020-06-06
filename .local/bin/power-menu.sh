#!/bin/sh
# Backup all files under home directory to a single # floppy
# Display message with option to cancel
input=/tmp/powermenu_input
output=/tmp/powermenu_output

function confirm() {
	# dialog --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}    
    dialog --title "$1" --menu "$2\nAre you sure?" 10 30 3\
        1 Yes\
        2 No 2>"${input}"

    select=$(<"${input}")
    
    case $select in
        1)
            case $1 in
                Logout) i3-msg exit;;
                Reboot) reboot;;
                Poweroff) poweroff;;
            esac
            ;;
    esac
}

while true 
do
    dialog --menu "What would you want to do?" 11 30 4\
        0 Cancel\
        1 Logout\
        2 Reboot\
        3 Poweroff 2>"${input}"

    select=$(<"${input}")

    case $select in
        0) break;;
        1) confirm "Logout" "Loggin out of i3 session. " ;;
        2) confirm "Reboot" "Restarting system. " ;;
        3) confirm "Poweroff" "Turning off system. " ;;
    esac
done

# if temp files found, delete em
[ -f $output ] && rm $output
[ -f $input ] && rm $input
