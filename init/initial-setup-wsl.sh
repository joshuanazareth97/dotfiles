#!/usr/bin/env bash

# *** install required packages ***
# basics
sudo apt-get install -Y build-essential make git
# install fira code font
sudo apt install fonts-firacode

# nvm & node
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
nvm install 18
nvm install 16
nvm install 14

# python
sudo apt-get install python3-venv
sudo apt-get install python3-pip
curl -sSL https://install.python-poetry.org | python3 -


# install zsh
sudo apt install zsh
bash ./inititial-setup-base.sh

