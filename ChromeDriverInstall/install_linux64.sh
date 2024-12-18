#!/bin/bash

# ------------------------------------------------------------
# Chrome & Chromedriver Installation Script, Intended for Debian based x86 Linux
# ------------------------------------------------------------

set -e # exit on error

echo "Enter Directory to save downloads to"
read directory

echo "Updating Packages"
sudo apt-get update
sudo apt install wget

wget -P $directory/ https://dl.google.com/linux/direct/google-chrome-stale_current_amd64.deb

sudo dpkg -i $directory/google-chrome*.deb

wget -P $directory/ https://storage.googleapis.com/chrome-for-testing-public/ /linux64/chromedriver-linux64.zip

unzip $directory/chrome-linux64.zip

sudo mv chromedriver /usr/local/bin
sudo chmod +x /usr/local/bin/chromedriver

echo "Successful downloaded chromedriver"

