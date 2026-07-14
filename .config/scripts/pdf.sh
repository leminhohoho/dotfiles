#!/bin/bash

SELECTED_PDF=$(find "$HOME/Downloads" -type f -name "*.pdf" | fzf --color="bg:-1,gutter:-1")

if [ -n "$SELECTED_PDF" ]; then
    zathura --fork "$SELECTED_PDF"
fi
