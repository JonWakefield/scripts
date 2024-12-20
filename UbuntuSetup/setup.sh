#!/bin/bash

# ------------------------------------------------
# Ubuntu Development Environment Setup Script
# ------------------------------------------------

set -e


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

# Core Dev Tools
DEV_TOOLS=(
    "tmux"          
    "zsh"           
    "fzf"           # Fuzzy finder
    "ripgrep"       # Fast search tool
    "apt-transport-https"  # Allows secure package downloads
)

apt update

# Install dev tools
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

# Cleanup
apt autoremove -y

echo "Ubuntu Development Environment Setup Complete!"
echo "Remember to restart your terminal or log out/in to apply changes."


