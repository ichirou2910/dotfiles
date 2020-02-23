# Session
export WM="i3"

# Default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"
export FILE="ranger"
export STATUSBAR="polybar"
export APPLAUNCHER="rofi"

# Directories
export ZDOTDIR="$HOME/.config/zsh"
export SCREENSHOTDIR="$HOME/Pictures/Screenshots"

# PATH
export JAVA_HOME=/usr/lib/jvm/jdk-11.0.4
export PATH=$JAVA_HOME/bin:$PATH

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
