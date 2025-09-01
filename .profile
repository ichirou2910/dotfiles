export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

# Default programs
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export TERM=xterm-kitty

# Directories
# export ZDOTDIR="$HOME/.config/zsh"

export PATH="$PATH:/home/ichirou2910/.nix-profile/bin"

# Added by Toolbox App
export PATH="$PATH:/home/ichirou2910/.local/share/JetBrains/Toolbox/scripts"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/ichirou2910/.lmstudio/bin"

export MANPAGER="nvim +Man!"
. "$HOME/.cargo/env"
