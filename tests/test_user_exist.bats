#!/usr/bin/env bats

setup() {
    source ./utils.sh
}

@test "user_exist return 0 for existing user" {
    getent() { [ "$1" = "passwd" ] && [ "$2" = "mockuser" ] && echo "mockuser"; }
    run user_exists "mockuser"
    [ "$status" -eq 0 ]
}

@test "user_exist return 1 for non existing user" {
    run user_exists "mockuser"
    [ "$status" -eq 1 ]
}
