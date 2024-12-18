#!/bin/bash

# ------------------------------------------------------------
# Selenium Installation Script, Intended for ARM Architecture (RPI)
# ------------------------------------------------------------

set -e # exit on error

echo "Updating Packages"
sudo apt-get update

echo "Checking Python and pip installation"
if ! command -v python3 &> /dev/null
then
	echo "Installing Python"
	sudo apt-get install -y python3
fi

if ! command -v pp3 &> /dev/null
then
	echo "Installing pip..."
	sudo apt-get install -y python3-pip
fi

echo "Installing Neccessary dependencies"
sudo apt-get install -y \
	chromium-browser \
	chromium-chromedriver \
	wget

pip3 install selenium
pip3 install webdriver-manager

echo "Checking Successful Installing"
python3 -c "import selenium; print('selenium installed successfully. Version: ', selenium.__version__)"

