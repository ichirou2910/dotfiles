#!/bin/sh

case "$1" in
    --info)
        if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
            updates_arch=0
        fi

        if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
            updates_aur=0
        fi

        updates=$(("$updates_arch" + "$updates_aur"))

        if [ "$updates" -gt 0 ]; then
            echo "$updates"
        else
            echo ""
        fi
        ;;
    --update)
        if pgrep -c $TERMINAL >/dev/null 2>&1; then
            tmux attach || tmux new-session
            tmux new-window -n Update yay -Syu
        else
            $TERMINAL -e tmux attach || tmux new-session
            tmux new-window -n Update yay -Syu
        fi
        ;;
esac
