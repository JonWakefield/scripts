#!/bin/bash

# Ubuntu Development Environment Setup Script

# Ensure script is run with sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

# Core Dev Tools
DEV_TOOLS=(
    "tmux"          # Terminal multiplexer
    "zsh"           # Advanced shell
    "fzf"           # Fuzzy finder
    "ripgrep"       # Fast search tool
    "apt-transport-https"  # Allows secure package downloads
)

# Update package lists
apt update

# Install core dev tools
apt install -y ${DEV_TOOLS[@]}

# Install Oh My Zsh
su - $SUDO_USER <<EOF
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set Zsh as default shell
chsh -s $(which zsh)
EOF

# Git Configuration Template
su - $SUDO_USER <<EOF
git config --global user.name "JonWakefield"
git config --global user.email "jonwakefield.mi@gmail.com"
git config --global core.editor "nvim"
EOF

# Cleanup
apt autoremove -y

echo "Ubuntu Development Environment Setup Complete!"
echo "Remember to restart your terminal or log out/in to apply changes."


