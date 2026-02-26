typeset -U path
path=(
  "$HOME/.dotnet/tools"
  "$HOME/.npm-packages/bin"
  "$HOME/.nix-profile/bin"
  "/opt/flutter/bin"
  "$HOME/Android/Sdk/cmdline-tools/latest/bin"
  $path
)

export NNN_PLUG='g:goto;x:extract'
export NNN_FIFO="/tmp/nnn.fifo"

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

autoload -U compinit; compinit
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

eval "$(starship init zsh)"

if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
  source /usr/share/nvm/init-nvm.sh
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

setopt autocd sharehistory hist_ignore_all_dups hist_ignore_space
setopt hist_find_no_dups hist_save_no_dups

autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

function zvm_after_init() {
    source <(fzf --zsh)
}

# NNN Wrapper
n() {
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    \nnn "$@"
    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
