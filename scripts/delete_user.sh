#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

: "${USERDEL_BIN:=/usr/sbin/userdel}"

check_username_exist() {
    local username="$1"
    if ! user_exists "$username"; then
        log ERROR "User $username not found"
        return 1
    fi
}

delete_user() {
    local username
    username="$(get_username)"
    check_username_exist "$username" || return 1
    if "$USERDEL_BIN" -r "$username"; then
        log INFO "User $username deleted"
    else
        log ERROR "Failed to delete user $username"
        return 1
    fi
}

main() {
    check_root || return 1
    delete_user "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi