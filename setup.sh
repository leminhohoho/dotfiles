#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir "$XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/fish" "$XDG_CONFIG_HOME"/fish

echo "All packages are installed"


