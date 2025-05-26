#!/bin/bash

# ------------------------------------------------
# Ubuntu Development Environment Setup Script
# ------------------------------------------------

set -e
NERD_FONTS_VERSION="v3.3.0"
NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/JetBrainsMono.zip"

# Core Dev Tools
DEV_TOOLS=(
    "tmux"          
    "zsh"           
    "fzf"           # Fuzzy finder
    "ripgrep"       # Fast search tool
    "apt-transport-https"  # Allows secure package downloads
    "ufw"
    "sqlite3"
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

echo "Downloading jetbrains nerdfonts"
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts $NERD_FONTS_URL
unzip ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/
sudo rm ~/.local/share/fonts/JetBrainsMono.zip
fc-cache -fv # updates font cache

echo "Downloading Tmux Plugin Manager (TPM)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

# setup Catpuccin themes for zsh
#mkdir -p ~/.config/tmux/plugins/catppuccin
#git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
#echo "run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux" >> ~/.tmux.conf

# Cleanup
sudo apt autoremove -y

echo "Ubuntu Development Environment Setup Complete!"
echo "Remember to restart your terminal or log out/in to apply changes."


