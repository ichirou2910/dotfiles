#!/bin/sh
# Backup all files under home directory to a single # floppy
# Display message with option to cancel
input=/tmp/powermenu_input
output=/tmp/powermenu_output

function confirm() {
	# dialog --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}    
    dialog --title "$1" --menu "$2\nAre you sure?" 11 30 3\
        1 Yes\
        2 No 2>"${input}"

    select=$(<"${input}")
    
    case $select in
        1)
            case $1 in
                Logout) 
                    if [ "$WM" = "awesome" ]; then
                        echo 'awesome.quit()' | awesome-client
                    elif [ "$WM" = "i3" ]; then
                        i3-msg exit
                    fi;;
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
        1) confirm "Logout" "Loggin out of $WM session. " ;;
        2) confirm "Reboot" "Restarting system. " ;;
        3) confirm "Poweroff" "Turning off system. " ;;
    esac
done

# if temp files found, delete em
[ -f $output ] && rm $output
[ -f $input ] && rm $input
