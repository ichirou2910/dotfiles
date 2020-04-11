# Session
export WM="i3"

# Default programs
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export TERMINAL="alacritty"
export BROWSER="vivaldi-stable"
export READER="zathura"
export FILE="ranger"
export STATUSBAR="polybar"
export APPLAUNCHER="rofi"

# Directories
export ZDOTDIR="$HOME/.config/zsh"
export SCREENSHOTDIR="$HOME/Pictures/Screenshots"
export BG_NOTES="$HOME/.config/wallpaper/notes.txt"
export BARRIER_CFG="$HOME/.config/barrier.sgc"

# PATH
export JAVA_HOME=/usr/lib/jvm/jdk-11.0.4
export PATH=$JAVA_HOME/bin:$PATH

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
