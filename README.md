# Joshua's Dotfiles

This repository contains the dotfiles and scripts used by Joshua to set up and customize his development environment. It includes configurations for Zsh, Neovim, Visual Studio Code, and various other tools and utilities.

## Structure

- `config/`: Contains configuration files for Zsh and Git.
  - `.gitconfig`: Git configuration settings.
  - `.zsh-profile`, `.zshenv`, `.zshrc`: Zsh configuration files.
- `init/`: Setup helpers and OS-specific bootstrap scripts.
  - `initial-setup-base.sh`: Shared setup for shell tooling and dotfile symlinks.
  - `initial-setup-mac.sh`: Setup script for macOS.
  - `initial-setup-wsl.sh`: Setup script for Ubuntu/WSL environments that use `apt`.
  - `setup-common.sh`: Shared logging and error handling helpers for setup scripts.
- `nvim/`: Configuration for Neovim.
  - `coc-settings.json`: Settings for the Conquer of Completion (coc) plugin.
  - `init.vim`: Neovim initialization file.
- `scaffold.sh`: Entry point that clones or updates the repo under `~/development/dotfiles` and runs the OS-specific setup.
- `vscode/`: Configuration for Visual Studio Code.
  - `joshua_dev.code-profile`: Visual Studio Code profile.

## Installation

Run the bootstrap script directly:

```
curl -fsSL https://raw.githubusercontent.com/joshuanazareth97/dotfiles/master/scaffold.sh | bash
```

This downloads `scaffold.sh`, which then clones or updates the repository at `~/development/dotfiles` and runs the appropriate OS-specific setup script.

Using `curl ... | bash` is convenient, but it is not the best practice because it executes remote code immediately without giving you a chance to inspect it first. A safer alternative is to download the script, review it, and then run it locally.

## Contributing

Feel free to fork this repository and customize the dotfiles to fit your own needs. Contributions to improve the existing configurations are welcome.
