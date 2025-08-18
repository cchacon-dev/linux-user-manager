#!/usr/bin/env bats

setup() {
    date() { echo "2025-08-18 12:00:00"; }
    source ./utils.sh
}

@test "INFO logs go to stdout" {
    run log INFO "message"
    [ "$status" -eq 0 ]
    [ "$output" = "[2025-08-18 12:00:00] [INFO] message" ]
}

@test "DEBUG logs go to stdout" {
    run log DEBUG "message"
    [ "$status" -eq 0 ]
    [ "$output" = "[2025-08-18 12:00:00] [DEBUG] message" ]
}

@test "WARN logs go to stderr with timestamp" {
    run log WARN "something failed"
    [ "$status" -eq 0 ]
    [ "$output" = "[2025-08-18 12:00:00] [WARN] something failed" ]
}

@test "ERROR logs go to stderr with timestamp" {
    run log ERROR "something failed"
    [ "$status" -eq 0 ]
    [ "$output" = "[2025-08-18 12:00:00] [ERROR] something failed" ]
}

@test "logs without log level go to stdout as error" {
    run log "message"
    [ "$status" -eq 1 ]
    [ "$output" = "Invalid log level: message" ]
}

@test "logs with wrong log level go to stdout as error" {
    run log WRONGLOG "message"
    [ "$status" -eq 1 ]
    [ "$output" = "Invalid log level: WRONGLOG" ]
}
