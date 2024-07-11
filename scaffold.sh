#! /usr/bin/env bash

# create dev folder and clone dotfiles
cd $HOME
mkdir development & cd development
git clone https://github.com/joshuanazareth97/dotfiles.git

base_setup_file=$HOME/development/dotfiles/init/initial-setup-base.sh

os_type=$(uname -s)
case "$os_type" in
    Linux)
        os_setup_file=$HOME/development/dotfiles/init/initial-setup-wsl.sh
        ;;
    Darwin)
        os_setup_file=$HOME/development/dotfiles/init/initial-setup-mac.sh
        ;;
    *)
        echo "Unrecognized OS. Please run the required scripts manually."
        exit 1
        ;;
esac

chmod +x $os_setup_file
bash $os_setup_file

chmod +x $base_setup_file
bash $base_setup_file
