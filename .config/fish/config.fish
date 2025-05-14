set -g -x fish_greeting ''

function fish_prompt
    string join '' -- (set_color green) '[' $USER ']' (set_color blue) (prompt_pwd) (set_color normal) '> '
end

set -e OPENAI_API_KEY
set -x ELECTRON_OZONE_PLATFORM_HINT wayland
set -x QT_QPA_PLATFORM wayland
set -x GDK_BACKEND wayland
set -x XDG_CONFIG_HOME "$HOME/.config"

set -x MANPAGER "nvim +Man!"
set -x FZF_DEFAULT_OPTS "--color 'bg:#181818'"

fish_add_path /bin
fish_add_path ~/bin
fish_add_path /opt/homebrew
fish_add_path /opt/homebrew/bin
fish_add_path /usr/bin
fish_add_path /usr/local/bin
fish_add_path go/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

function dotfiles
    /usr/bin/git --git-dir=$HOME/dot-files/ --work-tree=$HOME $argv
end

# LINUX UTILITIES

function brightness
   /bin/brightnessctl -d "apple-panel-bl" set $argv 
end

# function pdf
#     /bin/zathura $argv& && disown
# end

function run_electron
    $argv --appimage-extract-and-run --js-flags="--nodecommit_pooled_pages" & 
    disown
end

starship init fish | source
