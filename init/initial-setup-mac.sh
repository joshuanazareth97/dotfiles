#!/usr/bin/env bash

# *** Essential Packages ***

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# NVM and Node
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
nvm install 18
nvm install 16
nvm install 14

# fira code font
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

