# Session
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# Default programs
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export TERMINAL="alacritty"
export BROWSER="microsoft-edge-dev"
export READER="zathura"
export FILE="ranger"
export STATUSBAR="polybar"
export APPLAUNCHER="rofi"

# Directories
export ZDOTDIR="$HOME/.config/zsh"
export SCREENSHOTDIR="$HOME/Pictures/Screenshots"
export BG_NOTES="$HOME/.config/wallpaper/notes.txt"

# PATH
export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
# 	exec startx
# fi
