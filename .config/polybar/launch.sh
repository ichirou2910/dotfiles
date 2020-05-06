#!/usr/bin/env zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
echo "---" | tee /tmp/polybar_log

if type "xrandr"; then
    echo "Monitor found" >> /tmp/polybar_log
	for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
        if [ $m == 'DP-1' ]
        then
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r sub-right 2> /tmp/polybar_log &
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r sub-left 2> /tmp/polybar_log &
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r sub-center 2> /tmp/polybar_log &
        else
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r main-right 2> /tmp/polybar_log &
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r main-center 2> /tmp/polybar_log &
            MONITOR=$m polybar -c $HOME/.config/polybar/config -r main-left 2> /tmp/polybar_log &
        fi
	done
else
    echo "No monitor returned" | tee /tmp/polybar_log
	polybar -c $HOME/.config/polybar/config -r main-right 2> /tmp/polybar_log &
	polybar -c $HOME/.config/polybar/config -r main-center 2> /tmp/polybar_log &
	polybar -c $HOME/.config/polybar/config -r main-left 2> /tmp/polybar_log &
fi


echo "Bars launched...."
