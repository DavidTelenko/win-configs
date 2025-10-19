#!/bin/bash

# modifying operations

cp -rf ./keyd /etc/keyd
git config --global --add include.path "$(pwd)/git/.gitconfig"

# systemctl

sudo systemctl enable --now keyd
