#!/usr/bin/env bash

timestamp_utc() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

current_script_name() {
    printf '%s\n' "${SCRIPT_NAME:-$(basename "${0:-script}")}"
}

log_with_level() {
    local level=${1:?level is required}
    shift
    printf '%s [%s] %s: %s\n' "$(timestamp_utc)" "$(current_script_name)" "$level" "$*"
}

log_info() {
    log_with_level INFO "$*"
}

log_warn() {
    log_with_level WARN "$*"
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
