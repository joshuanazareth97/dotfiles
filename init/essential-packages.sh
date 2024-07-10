#!/usr/bin/env bash

# basics
sudo apt-get install -Y build-essential make 

# nvm & node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 18

# python
sudo apt-get install python3-venv
sudo apt-get install python3-pip
curl -sSL https://install.python-poetry.org | python3 -