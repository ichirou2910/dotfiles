# Path to your oh-my-zsh installation.
export ZSH="/home/ichirou2910/.oh-my-zsh"

export LIBVIRT_DEFAULT_URI="qemu:///system"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-vi-mode fast-syntax-highlighting zsh-autosuggestions)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

source /usr/share/z/z.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

_comp_options+=(globdots)		# Include hidden files.

#autoload -U promptinit; promptinit
autoload -Uz compinit

for dump in ~/.config/zsh/.zcompdump(N.mh+24); do
    compinit
done

compinit -C
#prompt spaceship
  # char
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_CHAR_SYMBOL_SECONDARY="⋮ "
SPACESHIP_CHAR_COLOR_SUCCESS="#148fee"
SPACESHIP_VI_MODE_SHOW=false
  # git prompt
SPACESHIP_GIT_STATUS_DELETED="X"
SPACESHIP_GIT_STATUS_BEHIND=""
SPACESHIP_GIT_STATUS_AHEAD=""
SPACESHIP_GIT_STATUS_DIVERGED=""
  # jobs
SPACESHIP_JOBS_PREFIX=" "
SPACESHIP_JOBS_SUFFIX=" "
SPACESHIP_JOBS_AMOUNT_PREFIX=" "
  # misc
SPACESHIP_EXEC_TIME_COLOR=magenta
SPACESHIP_DIR_COLOR=blue
SPACESHIP_PACKAGE_SHOW=false
  # prefix
SPACESHIP_PROMPT_DEFAULT_PREFIX="· "
SPACESHIP_HOST_PREFIX="· "
SPACESHIP_DIR_PREFIX="· "
SPACESHIP_GIT_PREFIX="· "
SPACESHIP_DOCKER_PREFIX="· "
SPACESHIP_PACKAGE_PREFIX="· "
SPACESHIP_NODE_PREFIX="· "
SPACESHIP_DOTNET_PREFIX="· "
SPACESHIP_EXEC_TIME_PREFIX="· "

# ZSH_HIGHLIGHT_STYLES[alias]="fg=#88c0d0"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM=xterm-kitty

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# NNN integrate
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
n()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# # Change cursor shape for different vi modes.
# function zle-line-init zle-keymap-select {
#   RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#   RPS2=$RPS1
#   zle reset-prompt
# }
# zle -N zle-keymap-select
# zle -N zle-line-init

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey "^P" up-line-or-history
bindkey "^[OA" up-line-or-history
bindkey "^[[5~" up-line-or-history
bindkey "^[[A" up-line-or-search
bindkey "^N" down-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[B" down-line-or-search

# Extras files
extras=("zpaths" "zfuncs" "zvars" "zaliasrc")
for e in "${extras[@]}"; do
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/$e" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/$e"
done

eval "$(rbenv init - zsh)"
