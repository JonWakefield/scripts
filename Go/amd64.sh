#!/bin/bash
# ------------------------------------------------------------------ 
# Golang install script, intended for linux, x86 based devices
# ------------------------------------------------------------------

set -e

GO_VERSION="1.23.4"
DOWNLOAD_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

read -p "Remove Previous Go version if exists (y/n)? " removePrev
if [ "$removePrev" = "y" ]; then
	echo "Removing Previous Go version"
	sudo rm -rf /usr/local/go
fi

sudo apt update
sudo apt install wget

# download
wget -q $DOWNLOAD_URL -O /tmp/go${GO_VERSION}.tar.gz

# extract tarball
sudo tar -C /usr/local -xzf /tmp/go${GO_VERSION}.tar.gz

# cleanup 
sudo rm /tmp/go${GO_VERSION}.tar.gz
echo "successfully installed Golang version ${GO_VERSION}"

echo "Adding Go to User Path"
PROFILE_FILE="~/.zshrc"
#if [[ $SHELL == *"zsh"* ]]; then
#	PROFILE_FILE="~/.zshrc"
#fi

if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ${PROFILE_FILE}; then
	echo "export PATH=\$PATH:/usr/local/go/bin" >> ${PROFILE_FILE}
fi

# load updated path
eval "$(tail -n 1 ${PROFILE_FILE})"


echo "Go ${GO_VERSION} installation completed successfully"
