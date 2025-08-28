#!/usr/bin/env bats

setup() {
    source ./utils.sh
}

@test "get_username return given username" {
    run get_username "testuser"
    [ "$status" -eq 0 ]
    [ "$output" = "testuser" ]
}