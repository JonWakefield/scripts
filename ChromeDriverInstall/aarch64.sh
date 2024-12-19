#!/bin/bash

# ------------------------------------
# Chrome & ChromeDriver installation Script, Intended for arm64 based devices
# Uses unofficial chromedriver builds
# ------------------------------------

set -e

echo "Enter Directory to save downloads to"

INSTALL_DIR="/usr/local/bin"
CHROMEDRIVER_VERSION="114.0.5735.90"
DOWNLOAD_URL="https://github.com/electron/electron/releases/download/v${CHROMEDRIVER_VERSION}/chromedriver-v${CHROMEDRIVER_VERSION}-linux-arm64.zip"

# update and install necessary dependencies
sudo apt-get update
sudo apt-get install -y \
	chromium-browser \
	chromium-chromedriver \
	wget \
	unzip


mkdir -p $INSTALL_DIR

echo "Downloading driver"
wget -O /tmp/chromedriver.zip $DOWNLOAD_URL
unzip -o /tmp/chromedriver.zip -d /tmp/

echo "Installing Driver"
sudo mv /tmp/chromedriver $INSTALL_DIR/chromedriver
sudo chmod +x $INSTALL_DIR/chromedriver

# clean up 
rm -f /tmp/chromedriver.zip

echo "Verifying Installation, chromedriver version:"
chromedriver --version

echo "Chrome driver is now installed at: ${INSTALL_DIR}/chromedriver"


