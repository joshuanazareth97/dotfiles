#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly BASE_SETUP_FILE="${DOTFILES_BASE_SETUP:-$DOTFILES_ROOT/init/initial-setup-base.sh}"
readonly SETUP_COMMON_FILE="$SCRIPT_DIR/setup-common.sh"

source "$SETUP_COMMON_FILE"
trap 'setup_err_trap "$LINENO" "$BASH_COMMAND"' ERR

find_brew() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return 0
  fi

  local candidate
  for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

ensure_homebrew() {
  local brew_path=""
  if brew_path="$(find_brew)"; then
    log_info "Homebrew already installed"
  else
    log_info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew_path="$(find_brew)" || fatal "brew executable not available after installation"
  fi

  eval "$("$brew_path" shellenv)"
}

ensure_cask_fonts() {
  if ! brew list --cask font-fira-code >/dev/null 2>&1; then
    log_info "Installing Fira Code font"
    brew install --cask font-fira-code
  else
    log_info "Fira Code font already installed"
  fi
}

ensure_nvm() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  if [[ ! -f "$NVM_DIR/nvm.sh" ]]; then
    log_info "Installing nvm"
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
  else
    log_info "nvm already installed"
  fi

  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh"
}

install_node_versions() {
  local version
  # TODO: Ask user which versions 
  for version in 22 20 18; do
    if nvm ls --no-colors "$version" >/dev/null 2>&1; then
      log_info "Node.js $version already installed"
    else
      log_info "Installing Node.js $version"
      nvm install "$version"
    fi
  done
}

run_base_setup() {
  if [[ ! -f "$BASE_SETUP_FILE" ]]; then
    fatal "base setup script not found at $BASE_SETUP_FILE"
  fi

  log_info "Running base setup"
  bash "$BASE_SETUP_FILE"
}

main() {
  log_info "Starting macOS initial setup"
  ensure_homebrew
  ensure_cask_fonts
  ensure_nvm
  install_node_versions
  run_base_setup
  log_info "macOS initial setup complete"
}

main "$@"
