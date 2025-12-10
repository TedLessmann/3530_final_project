#!/bin/bash

PACKAGES=("curl" "vim" "git")

echo "Updating packages: ${PACKAGES[*]}"

sudo apt update
sudo apt install -y "${PACKAGES[@]}"

echo "Package update complete."
