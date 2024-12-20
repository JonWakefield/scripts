#!/bin/bash

# ------------------------------------------------
# Ubuntu Development Environment Setup Script
# ------------------------------------------------

set -e

# Core Dev Tools
DEV_TOOLS=(
    "tmux"          
    "zsh"           
    "fzf"           # Fuzzy finder
    "ripgrep"       # Fast search tool
    "apt-transport-https"  # Allows secure package downloads
)

sudo apt update

# Install dev tools
sudo apt install -y ${DEV_TOOLS[@]}

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set Zsh as default shell
sudo chsh -s $(which zsh)

# Cleanup
sudo apt autoremove -y

echo "Ubuntu Development Environment Setup Complete!"
echo "Remember to restart your terminal or log out/in to apply changes."


