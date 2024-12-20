#!/bin/bash

# ------------------------------
# Git & Github connection setup for Ubuntu Linux
# ------------------------------

read -p "git name: " git_name
read -p "git email: " git_email

echo "Using Name ${git_name}, using email ${git_email}"

set -e
sudo apt update && sudo apt install git

exit 1
git config --global user.name "${git_name}"
git config --global user.email "${git_email}"

exit 1
echo "Generating an ED25519 key"
ssh-keygen -t ed25519 -C "${git_email}"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Setting up commit signing with SSH Key"
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true

# additional settings
git config --global init.defaultBranch main
git config --global url."https://".insteadOf git://
git config --global merge.verifySignatures true

echo "Created SSH Key for github."
echo "Go to Github → Settings → SSH and GPG keys"
echo "Click 'New SSH Key'"
echo "Paste public key"
echo "run 'ssh -T git@github.com' to test connetion"
