# Joshua's Dotfiles

This repository contains the dotfiles and scripts used by Joshua to set up and customize his development environment. It includes configurations for Zsh, Neovim, Visual Studio Code, and various other tools and utilities.

## Structure

- `config/`: Contains configuration files for Zsh and Git.
  - `.gitconfig`: Git configuration settings.
  - `.zsh-profile`, `.zshenv`, `.zshrc`: Zsh configuration files.
- `init/`: Scripts for initial setup on macOS and WSL.
  - `essential-packages.sh`: Script to install essential packages.
  - `initial-setup-mac.sh`: Setup script for macOS.
  - `initial-setup-wsl.sh`: Setup script for Windows Subsystem for Linux (WSL).
- `nvim/`: Configuration for Neovim.
  - `coc-settings.json`: Settings for the Conquer of Completion (coc) plugin.
  - `init.vim`: Neovim initialization file.
- `scaffold.sh`: Script to scaffold new systems.
- `vscode/`: Configuration for Visual Studio Code.
  - `joshua_dev.code-profile`: Visual Studio Code profile.

## Installation

Run the following command in a bash terminal to scaffold the rpository:

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/joshuanazareth97/dotfiles/master/scaffold.sh)"
```

## Contributing

Feel free to fork this repository and customize the dotfiles to fit your own needs. Contributions to improve the existing configurations are welcome.
