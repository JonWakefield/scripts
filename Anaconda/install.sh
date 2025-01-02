#!/bin/bash

# ---------------------------------
# Anaoncda Install script intended for Ubuntu Linux
# ---------------------------------

set -e 

#sudo apt-get install libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

curl -o ~/anaconda_install.sh -O https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh

bash ~/anaconda_install.sh
