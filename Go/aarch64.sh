#!/bin/bash

# --------------------------------------------------
# Golang install script, intended for linux, arm64 based devices
#---------------------------------------------------

GO_VERSION="1.23.4"
DOWNLOAD_URL="https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz"


read -p "Remove Previous Go version if exists (y/n)? " removePrev
if [ "$removePrev" = "y" ]; then
	echo "Removing Previous Go version"
	rm -rf /usr/local/go
fi

wget -P /usr/local $DOWNLOAD_URL

tar -C /usr/local -xzf go$GO_VERSION.linux-arm64.tar.gz

echo "successfully installed Golang version ${GO_VERSION}"
echo "Add binaries to path. 'export PATH=$PATH:/usr/local/go/bin'"
