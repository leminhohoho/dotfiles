#!/bin/bash

export XDG_CONFIG_HOME = "$HOME"/.config
mkdir "XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/fish" "XDG_CONFIG_HOME"/fish

packages=(
    fd
    ripgrep
    starship
    lazygit
)

for package in "${packages[@]}"; do
    echo "Installing $package ..."
    /home/linuxbrew/.linuxbrew/bin/brew install "$package"
done

echo "All packages are installed"


