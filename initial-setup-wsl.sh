#!/usr/bin/env bash

# install zsh, oh my zsh and git
sudo apt install zsh
zsh --version && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt-get install git

# install needed plugins
# spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
#zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install fira code font
sudo apt install fonts-firacode

# create dev folder and clone dotfiles
cd $HOME
mkdir development && cd development
git clone https://github.com/joshuanazareth97/dotfiles.git
