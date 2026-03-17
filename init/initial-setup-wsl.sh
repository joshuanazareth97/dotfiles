#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BASE_SETUP_SCRIPT="${DOTFILES_BASE_SETUP:-$SCRIPT_DIR/initial-setup-base.sh}"
readonly NVM_DIR="$HOME/.nvm"
readonly NODE_VERSIONS=(18 16 14)
readonly SETUP_COMMON_FILE="$SCRIPT_DIR/setup-common.sh"

source "$SETUP_COMMON_FILE"
trap 'setup_err_trap "$LINENO" "$BASH_COMMAND"' ERR

install_apt_packages() {
  local packages=(build-essential make git curl fonts-firacode python3-venv python3-pip zsh)
  log_info "Refreshing apt metadata"
  sudo apt-get update
  log_info "Installing apt packages: ${packages[*]}"
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y "${packages[@]}"
}

install_poetry() {
  if command -v poetry >/dev/null 2>&1; then
    log_info "Poetry already available"
    return
  fi

  log_info "Installing Poetry"
  curl -sSL https://install.python-poetry.org | python3 -
}

ensure_nvm() {
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    log_info "nvm already installed at $NVM_DIR"
  else
    log_info "Installing nvm"
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
    log_info "nvm installer completed"
  fi

  if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck disable=SC1090
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"
  else
    fatal "Unable to source nvm (missing $NVM_DIR/nvm.sh)"
  fi
}

install_node_versions() {
  for version in "${NODE_VERSIONS[@]}"; do
    if nvm ls --no-colors "$version" >/dev/null 2>&1; then
      log_info "Node.js $version already installed"
    else
      log_info "Installing Node.js $version"
      nvm install "$version"
    fi
  done
}

run_base_setup() {
  if [[ ! -f "$BASE_SETUP_SCRIPT" ]]; then
    fatal "Base setup script missing: $BASE_SETUP_SCRIPT"
  fi

  log_info "Executing base setup script"
  bash "$BASE_SETUP_SCRIPT"
}

main() {
  install_apt_packages
  install_poetry
  ensure_nvm
  install_node_versions
  run_base_setup
}

main
