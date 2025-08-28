#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

: "${USERADD_BIN:=/usr/sbin/useradd}"

check_username_exist() {
    local username="$1"
    if user_exists "$username"; then
        log ERROR "User $username already exists"
        return 1
    fi
}

get_password(){
    local password="$1"
    if [[ -z "$password" ]]; then
        read -r -p -s "Please enter a strong password: " password
    fi
    echo "$password"
}

create_user() {
    local username
    username="$(get_username "$1")"
    check_username_exist "$username" || return 1
    if "$USERADD_BIN" -m -g users "$username"; then
        log INFO "User $username created"
    else
        log ERROR "Failed to create user $username"
        return 1
    fi
}

main() {
    check_root || return 1
    create_user "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi