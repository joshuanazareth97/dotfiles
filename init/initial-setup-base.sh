#!/usr/bin/env bash
set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_DIR="$DOTFILES_ROOT/config"
readonly SETUP_COMMON_FILE="$SCRIPT_DIR/setup-common.sh"

source "$SETUP_COMMON_FILE"
trap 'setup_err_trap "$LINENO" "$BASH_COMMAND"' ERR
: "${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}"

ensure_repo() {
    local repo_url=$1
    local dest=$2
    if [ -d "$dest/.git" ]; then
        log_info "Repository already present at $dest"
        return
    fi
    log_info "Cloning $repo_url into $dest"
    git clone --depth 1 "$repo_url" "$dest"
}

install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_info "Oh My Zsh already installed"
        return
    fi
    log_info "Installing Oh My Zsh"
    zsh --version
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

link_points_to_source() {
    local target=$1
    local source=$2
    [ -L "$target" ] && [ "$target" -ef "$source" ]
}

link_dotfiles() {
    local backup_root="$HOME/.dotfiles-backup"
    local backup_dir=""
    local source
    for source in "$CONFIG_DIR"/.[!.]* "$CONFIG_DIR"/..?*; do
        [ -e "$source" ] || continue
        local name
        name="$(basename "$source")"
        local target="$HOME/$name"
        if [ -e "$target" ] || [ -L "$target" ]; then
            if link_points_to_source "$target" "$source"; then
                log_info "Link already correct for $name"
                continue
            fi
            if [ -z "$backup_dir" ]; then
                backup_dir="$backup_root/$(date -u +%Y%m%dT%H%M%SZ)"
                mkdir -p "$backup_dir"
                log_info "Created backup directory $backup_dir"
            fi
            log_info "Moving existing $target to backup"
            mv "$target" "$backup_dir/$name"
        fi
        ln -sf "$source" "$target"
        log_info "Linked $name -> $source"
    done
}

main() {
    install_oh_my_zsh
    log_info "Ensuring Oh My Zsh plugins/themes live under $ZSH_CUSTOM"
    mkdir -p "$ZSH_CUSTOM/themes" "$ZSH_CUSTOM/plugins"

    ensure_repo https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    ensure_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    mkdir -p "$ZSH_CUSTOM/plugins/poetry"
    if command -v poetry >/dev/null 2>&1; then
        log_info "Generating Poetry completions"
        poetry completions zsh > "$ZSH_CUSTOM/plugins/poetry/_poetry"
    else
        log_warn "Poetry is not installed; skipping Poetry completions"
    fi

    log_info "Linking config files from $CONFIG_DIR"
    link_dotfiles
}

main
