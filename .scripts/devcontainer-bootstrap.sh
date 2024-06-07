#!/bin/bash

# This script install dotfiles into devcontainers

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"

ln -sf "$PWD/.config/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/.config/zsh" "$XDG_CONFIG_HOME/zsh"

cp -ru "$PWD/.cache/*" "$XDG_CACHE_HOME/"
