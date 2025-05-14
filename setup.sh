#!/usr/bin/bash

fedora_version=$(sudo cat /etc/fedora-release)

cat << EOF

Asahi linux minimal setup
$fedora_version

EOF

echo "Press ENTER to continue"
read -n 1 -s -r -p "" </dev/tty

###################
### Wifi set up ###
###################

cat << EOF

WIFI connection

EOF

if ping -c1 -w1 1.1.1.1 >/dev/null 2>&1; then
	echo "Already connected to the internet, continue the setup process"
else
	echo "List of available network"
	nmcli device wifi list

	read -p "Please enter the name of the wifi to connect to: " wifi </dev/tty

	nmcli device wifi connect "$wifi" --ask
fi

########################################################
### Checking for update & installing essential tools ###
########################################################

echo -e "Checking for update\n"
sudo dnf update

echo -e "Installing essential tools\n"
sudo dnf install fastfetch htop neovim fish git openssh-server ufw brightnessctl

#########################
### Set up SSH server ###
#########################

sudo systemctl enable --now sshd
sudo systemctl status sshd
sudo ufw allow ssh
sudo systemctl start ufw
sudo ufw status


##########################
### Swap configuration ###
##########################

cat << EOF

Swap configuration

EOF

# Changing swappiness
swappiness=$(sudo cat /proc/sys/vm/swappiness)
echo "Current swapiness: $swappiness"
echo "Do you want to change your swapiness"
read -p "[y/n] " decision </dev/tty

while [ "$decision" != "y" ] && [ "$decision" != "n" ]
do
	read -p "[y/n] " decision </dev/tty
done

if [[ "$decision" == "n" ]]; then
	echo "Swappiness will be kept at $swappiness"
else
	# read -p "Enter a new swappiness value: " swappiness
	# sudo sysctl vm.swappiness="$swappiness"
	echo "You will be drop into the editor to edit the swappiness and the overcommit memory behavior, set it to vm.overcommit_memory=1 and also add kernel.printk = 1 4 1 7 for sliencing inputs, press ENTER to continue"
	read -n 1 -s -r -p "" </dev/tty
	sudo nvim /etc/sysctl.conf
	sudo sysctl -p
	echo "Your new swappiness is:$(sudo cat /proc/sys/vm/swappiness)" </dev/tty
fi
echo -e "\nYour current swap size:"
swapon -s


echo "Do you want to change your swapfile size ?"
read -p "[y/n] " decision </dev/tty

while [ "$decision" != "y" ] && [ "$decision" != "n" ]
do
	read -p "[y/n] " decision </dev/tty
done

if [[ "$decision" == "n" ]]; then
	echo "Skipping swapfile modification"
else
	read -p "Please enter the new swap size: " swap_size </dev/tty
	
	while true;
	do 
		if [[ "$swap_size" =~ ^-?[0-9]+GB$ ]]; then
			break
		fi

		read -p "Invalid format, please enter again: " swap_size </dev/tty
	done


	sudo swapoff /var/swap/swapfile >/dev/null 2>&1
	sudo rm /var/swap/swapfile >/dev/null 2>&1
	sudo fallocate -l "$swap_size" /var/swap/swapfile >/dev/null 2>&1
	sudo chmod 600 /var/swap/swapfile >/dev/null 2>&1
	sudo mkswap /var/swap/swapfile >/dev/null 2>&1
	sudo swapon /var/swap/swapfile >/dev/null 2>&1
	echo "New swap size: "
	swapon -s
fi

################################
### Performance optimization ###
################################

######################
### Changing shell ###
######################

if [[ "$SHELL" != "/bin/fish"  ]] && [[ "$SHELL" != "/usr/bin/fish" ]]; then
	chsh -s "$(which fish)"
fi

######################
### Setting up git ###
######################

cat << EOF

Setting up git

EOF

if [[ -z $(git config --get user.name) ]]; then
	read -p "Enter your github username: " github_username </dev/tty
	while [ github_username == "" ]
	do
		read -p "No name specified, please enter again: " github_username </dev/tty
	done
	git config --global user.name "$github_username"
fi

if [[ -z $(git config --get user.email) ]]; then
	read -p "Enter your github email: " github_email </dev/tty
	while [ github_email == "" ]
	do
		read -p "No emaill specified, please enter again: " github_email </dev/tty
	done
	git config --global user.email "$github_email"
fi

echo "Your github name is: $(git config --get user.name)"
echo "Your github email is: $(git config --get user.email)"

# SSH key setup
keys=$(ls ~/.ssh/id_* 2>/dev/null | grep -v '\.pub')

if [[ -z "$keys" ]]; then
	ssh-keygen

	echo "SSH key is created"
else
	echo "SSH key is already created"
fi

sudo cat ~/.ssh/id_ed25519.pub > /tmp/key.txt
echo -e "Your SSH key is:\n$(cat ~/.ssh/id_ed25519.pub)"
read -n 1 -s -r -p "Copy this key to your github page, press ENTER to continue" </dev/tty
echo ""

ssh -T git@github.com

#######################
### Languages setup ###
#######################

# Setting up snapd
echo "Setting up languages"
echo "Installing snapd..."
if ! command -v snap &> /dev/null; then
	sudo dnf install snapd
	read -n 1 -s -r -p "In order for snap to work, you have to logout and login again, press ENTER now to logout, after that, rerun the script again" </dev/tty
	loginctl terminate-user "$USER"
	sudo ln -s /var/lib/snapd/snap /snap
	sudo snap install hello-world
else 
	echo "snapd already installed"
fi
hello-world

# Installing go
echo "Installing Go..."
if ! command -v go &> /dev/null; then
	sudo snap install go --classic
else 
	echo "Go already installed"
fi
echo "Go version: $(go version)"

# Installing zig
echo "Installing Zig..."
if ! command -v zig &> /dev/null; then
	sudo snap install zig --beta --classic
else 
	echo "Zig already installed"
fi
echo "Zig version: $(zig version)"

# Installing node
echo "Installing Node..."
if ! command -v node &> /dev/null; then
	sudo snap install node --classic
else 
	echo "Node already installed"
fi
echo "Node version: $(node --version)"

# Installing java
echo "Installing Java..."
if ! command -v java &> /dev/null; then
	sudo dnf install java-latest-openjdk-devel.aarch64
else 
	echo "Java already installed"
fi
java -version

# Installing rust
echo "Installing Rust..."
if ! command -v  rustc &> /dev/null; then
	sudo snap install rustup --classic
	rustup default stable
else 
	echo "Rust already installed"
fi
echo "Rust version: $(rustc --version)"

# Installing C/C++
echo "Installing C/C++..."
if ! command -v  gcc&> /dev/null; then
	sudo dnf install clang
else 
	echo "C/C++ already installed"
fi

######################################################################
### Installing personalized tools for dotfiles related tools (TUI) ###
######################################################################
sudo dnf install fzf ripgrep
# install starhip
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
else 
    echo "Starship has already been installed"
fi
starship --version

#########################
### Initiate dotfiles ###
#########################

# Download dotfile manager
echo "Downloading doffy dotfiles manager..."
if ! command -v  doffy &> /dev/null; then
	go install github.com/leminhohoho/doffy@latest
else 
	echo "Doffy already installed"
fi

# Download the dotfiles
if ! ls $HOME/dotfiles &> /dev/null; then
	git clone git@github.com:leminhohoho/dotfiles.git
else
	echo "dotfiles already installed"
fi

# Remove the default config files
rm -rf $HOME/.config/fish

# Create the symlinks
$HOME/go/bin/doffy $HOME/dotfiles

###########################
### Installing Hyprland ###
###########################

# Install kitty and Hyprland and its dependencies
echo "Installing Hyprland and its dependencies"
sudo dnf copr enable solopasha/hyprland
sudo dnf install kitty hyprland hypridle hyprpaper hyprshot hyprpicker thunar rofi-wayland waybar

# Installing hyprland utilities

# Installing fonts 
FONT_GROUP_NAME="JetBrainsMono Nerd Font"
    if ! fc-list | grep -q "$FONT_GROUP_NAME"; then 
    mkdir -p "$HOME/.local/share/fonts"
    cd "$HOME/.local/share/fonts"
    curl -fLo "JetBrainsMonoNerdFont.zip" -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
    unzip "JetBrainsMonoNerdFont.zip"
    rm "JetBrainsMonoNerdFont.zip"
    fc-cache -fv
else
    echo "Font $FONT_GROUP_NAME already installed"
fi

##############################################
### Installing other quality of life tools ###
##############################################

# Installing browsers
echo "Installing browser"
sudo dnf install qutebrowser chromium

# Installing dev tools
echo "Installing dev tools"
sudo dnf copr enable atim/lazygit -y
sudo dnf install tmux cloc lazygit pipx
go install github.com/segmentio/golines@latest
pipx install black
sudo npm install -g fsouza/prettierd 
cargo install stylua
tmux -V
cloc --version
lazygit --version

# Installing OS related tools
echo "Installing OS related tools"
sudo dnf install gtk4 


# Installing miscellaneous tools
echo "Installing miscellanous tools"
sudo dnf install zathura zathura-pdf-poppler feh calibre mpv mpg123 youtube-dl pdflatex texlive-scheme-medium texlive texlive-standalone tex-preview ImageMagick

# Setting up Tmux plugin manager
if ! ls $HOME/.tmux/plugins/tpm &> /dev/null; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
	echo "tmux plugin manager already installed"
fi

# FIX: Fix keyboard not being able to use Win key
# TODO: Modularize the script and make it faster
# TODO: Make the script look nicer (more readable)
