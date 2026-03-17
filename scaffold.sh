#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

readonly SCRIPT_NAME="$(basename "${0:-scaffold.sh}")"
readonly DEVELOPMENT_DIR="$HOME/development"
readonly DOTFILES_REPO_DIR="$DEVELOPMENT_DIR/dotfiles"
readonly BASE_SETUP_FILE="$DOTFILES_REPO_DIR/init/initial-setup-base.sh"

timestamp_utc() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

log_with_level() {
    local level=${1:?level is required}
    shift
    printf '%s [%s] %s: %s\n' "$(timestamp_utc)" "$SCRIPT_NAME" "$level" "$*"
}

log_info() {
    log_with_level INFO "$*"
}

log_error() {
    log_with_level ERROR "$*" >&2
}

fatal() {
    trap - ERR
    log_error "Critical failure: $*"
    exit 1
}

setup_err_trap() {
    local line_number=${1:-unknown}
    local command=${2:-unknown}
    fatal "command '$command' failed at line $line_number"
}

trap 'setup_err_trap "$LINENO" "$BASH_COMMAND"' ERR

log_info "Ensuring development directory exists at $DEVELOPMENT_DIR"
mkdir -p "$DEVELOPMENT_DIR"
cd "$DEVELOPMENT_DIR"

log_info "Preparing dotfiles repository at $DOTFILES_REPO_DIR"
if [ -d "$DOTFILES_REPO_DIR/.git" ]; then
    log_info "Dotfiles repository already cloned; fetching updates"
    git -C "$DOTFILES_REPO_DIR" fetch --prune
elif [ -e "$DOTFILES_REPO_DIR" ]; then
    fatal "expected a git repository at $DOTFILES_REPO_DIR, but found an existing non-repository path"
else
    log_info "Cloning dotfiles repository"
    git clone https://github.com/joshuanazareth97/dotfiles.git "$DOTFILES_REPO_DIR"
fi

os_type=$(uname -s)
case "$os_type" in
    Linux)
        os_setup_file="$DOTFILES_REPO_DIR/init/initial-setup-wsl.sh"
        ;;
    Darwin)
        os_setup_file="$DOTFILES_REPO_DIR/init/initial-setup-mac.sh"
        ;;
    *)
        fatal "Unrecognized OS '$os_type'. Please run the required scripts manually."
        ;;
esac

if [ ! -f "$os_setup_file" ]; then
    fatal "OS setup script missing: $os_setup_file"
fi

chmod +x "$os_setup_file"

export DOTFILES_REPO_DIR
export DOTFILES_BASE_SETUP="$BASE_SETUP_FILE"

log_info "Running OS specific setup: $os_setup_file"
bash "$os_setup_file"
