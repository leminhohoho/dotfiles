#!/bin/bash

# Create the session detached
tmux new-session -d -s utilities

# Set up a custom key table and bind 'q' to detach
tmux set-option -t utilities key-table utilitiestable
tmux bind-key -T utilitiestable q detach

# Switch the session to the custom key table
tmux switch-client -t utilities -T utilitiestable

