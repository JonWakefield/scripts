#!/bin/bash

# ----------------------------------------------------------------------
# Docker Install Script, Intended for x86 devices running Debian Linux
# ----------------------------------------------------------------------

# ask to remove previous docker installs
read -p "Remove Previous Docker installation if exists (y/n)? " remove_prev
if [ "$remove_prev" = "y" ]; then
	echo "Removing Prev Docker installation"
	sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

	read -p "Remove all docker images, containers, volumes, etc. ? (y\n) " remove_data
	if [ "$remove_data" = "y" ]; then
		sudo rm -rf /var/lib/docker
		sudo rm -rf /var/lib/containerd
		sudo rm /etc/apt/sources.list.d/docker.list
		sudo rm /etc/apt/keyrings/docker.asc
	fi
fi


# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

echo "Docker successfully installed"

# add user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER
