#!/bin/sh

case "$1" in
    --clean)
        rm -rf ~/.local/share/Trash/files
        rm -rf ~/.local/share/Trash/info
        mkdir ~/.local/share/Trash/files
        mkdir ~/.local/share/Trash/info
        notify-send "Trash emptied!"
        ;;
    *)
        x=$(expr $(find ~/.local/share/Trash/files/ -maxdepth 1 | wc -l) - 1)
        if [ $x == 0 ];
        then
            echo "0"
        else
            echo "$x"
        fi
        ;;
esac
