#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

: "${USERADD_BIN:=/usr/sbin/useradd}"
: "${CHPASSWD_BIN:=/usr/sbin/chpasswd}"

check_username_exist() {
    local username="$1"
    if user_exists "$username"; then
        log ERROR "User $username already exists"
        return 1
    fi
}

create_user() {
    local username="${1:-}"
    local password="${2:-}"
    if [[ -z "$username" ]]; then
        username="$(get_username)"
    fi
    check_username_exist "$username" || return 1
    if "$USERADD_BIN" -m -g users "$username"; then
        log INFO "User $username created"
        
    else
        log ERROR "Failed to create user $username"
        return 1
    fi
    set_password "$username"
}

set_password(){
    local username="$1"
    local password="${2:-}"
    if [[ -z "$password" ]]; then
        password=$(echo -n "$(get_password)"| tr -d '\r\n')
    fi
    if echo "$username:$password" | "$CHPASSWD_BIN"; then
        
        log INFO "Password for User $username created"
    else 
        log ERROR "Failed to create password for user $username"
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