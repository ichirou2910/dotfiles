export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

# Default programs
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

# Added by Toolbox App
export PATH="$PATH:/home/ichirou/.local/share/JetBrains/Toolbox/scripts"

export PATH="$PATH:/home/ichirou/.dotnet/tools"
export PATH="$PATH:/home/ichirou/.npm-packages/bin"
export PATH="$PATH:/home/ichirou/.nix-profile/bin"
export PATH="$PATH:/home/ichirou/Android/Sdk/cmdline-tools/latest/bin"
export PATH="$PATH:/opt/flutter/bin"

export MANPAGER="nvim +Man!"
. "$HOME/.cargo/env"
