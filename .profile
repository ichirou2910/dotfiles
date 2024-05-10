export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

# Default programs
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export TERMINAL="alacritty"
export TERM=xterm-kitty
export READER="zathura"
export APPLAUNCHER="rofi"
export GOPATH="/home/ichirou2910/.local/share/go"

# Directories
export ZDOTDIR="$HOME/.config/zsh"
export SCREENSHOTDIR="$HOME/Pictures/Screenshots"
export BG_NOTES="$HOME/.config/wallpaper/notes.txt"

# Added by Toolbox App
export PATH="$PATH:/home/ichirou2910/.local/share/JetBrains/Toolbox/scripts"
