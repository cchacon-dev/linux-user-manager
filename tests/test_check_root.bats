#!/usr/bin/env bats

setup() {
    date() { echo "2025-08-18 12:00:00"; }
    source ./utils.sh
}

@test "User is root with no errors" {
    get_euid() { echo 0; }
    run check_root
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "User is not root with errors" {
    get_euid() { echo 1000; }
    run check_root
    [ "$status" -eq 1 ]
    [ "$output" = "[2025-08-18 12:00:00] [ERROR] This script must be run as root" ]
}