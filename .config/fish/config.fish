set -g -x fish_greeting ''


function fish_prompt
    string join '' -- (set_color green) '[' $USER ']' (set_color blue) (prompt_pwd) (set_color normal) '> '
end

set -e OPENAI_API_KEY
# set -x ELECTRON_OZONE_PLATFORM_HINT wayland
# set -x QT_QPA_PLATFORM wayland
# set -x GDK_BACKEND wayland
# set -x XDG_CONFIG_HOME "$HOME/.config"
# set -x QT_SCALE_FACTOR 1
set -x QT_QPA_PLATFORM wayland
set -x ELECTRON_OZONE_PLATFORM_HINT wayland
set -x GDK_BACKEND wayland
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x MOZ_ENABLE_WAYLAND 1
# set -x QT_SCALE_FACTOR 2  # Try this or unset QT_SCALE_FACTOR

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
fish_add_path ~/.config/scripts
fish_add_path /opt/nvim/bin


function dotfiles
    /usr/bin/git --git-dir=$HOME/dot-files/ --work-tree=$HOME $argv
end

# LINUX UTILITIES

function brightness
   /bin/brightnessctl -d "apple-panel-bl" set $argv 
end

function run_electron
    $argv --appimage-extract-and-run --js-flags="--nodecommit_pooled_pages" & 
    disown
end

starship init fish | source

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

function mpvbg
    mpv --no-video --loop=inf --hwdec=vaapi --ytdl-format=bestaudio --af-add=acompressor=ratio=4:threshold=0.1 --volume=54 $argv
end

function load_env_vars -d "Load variables in a .env file"
    set lines (cat $argv | string split -n '\n' | string match -vre '^#')
    for line in $lines
        set arr (string split -n -m 1 = $line)
        if test (count $arr) -ne 2
            continue
        end
        set -gx $arr[1] $arr[2]
    end
end

load_env_vars ~/.env

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

function l
    $HOME/.cargo/bin/exa -la --icons $argv
end

function code
    /bin/code --enable-features=UseOzonePlatform --ozone-platform=wayland $argv
end
