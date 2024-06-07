#!/bin/bash

# This script install dotfiles into devcontainers

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

ln -sf "$PWD/.config/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/.config/zsh" "$XDG_CONFIG_HOME/zsh"

exit 0
