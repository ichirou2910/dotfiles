#!/usr/bin/env zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
echo "---" | tee /tmp/polybar_log

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
		MONITOR=$m polybar -c $HOME/.config/polybar/config -r right 2> /tmp/polybar_log &
		MONITOR=$m polybar -c $HOME/.config/polybar/config -r center 2> /tmp/polybar_log &
		MONITOR=$m polybar -c $HOME/.config/polybar/config -r left 2> /tmp/polybar_log &
	done
else
	polybar -c $HOME/.config/polybar/config -r right 2> /tmp/polybar_log &
	polybar -c $HOME/.config/polybar/config -r center 2> /tmp/polybar_log &
	polybar -c $HOME/.config/polybar/config -r left 2> /tmp/polybar_log &
fi


echo "Bars launched...."
