#!/usr/bin/env bats

setup() {
     export TEST_TMPDIR="$BATS_TMPDIR"
    mkdir -p "$TEST_TMPDIR/bin"

    # Mock system commands (useradd, userdel)
    export USERDEL_BIN="$TEST_TMPDIR/bin/userdel"
    cat > "$USERDEL_BIN" <<'EOF'
#!/bin/bash
echo "MOCK userdel $*"
EOF
    chmod +x "$USERDEL_BIN"

    export USERDEL_BIN="$TEST_TMPDIR/bin/userdel"
    cat > "$USERDEL_BIN" <<'EOF'
check_root() { return 0; }
log() { echo "MOCK LOG $*"; }
user_exists() { return 0; } # default: user does NOT exist
EOF

    export SCRIPT_DIR="$TEST_TMPDIR/utils_mock"

    # Source the script under test
    source "$(dirname "$BATS_TEST_FILENAME")/../scripts/delete_user.sh"
}

teardown() {
    rm -f "$USERDEL_BIN"
}

@test "delete_user deletes the user successfully" {
    user_exists() { return 0; }
    run delete_user "testuser"
    [ "$status" -eq 0 ]
    echo "$output"
    [[ "$output" =~ "User testuser deleted" ]]
}

@test "delete_user fails, username not found" {
    user_exists() { return 1; }
    run delete_user "testuser"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "User testuser not found" ]]
}

@test "delete_user fails, userdel fails" {
    user_exists() { return 0; }
    echo 'exit 1' > "$USERDEL_BIN"
    run delete_user "testuser"
    [ "$status" -eq 1 ]
    echo "$output" 
    [[ "$output" =~ "Failed to delete user testuser" ]]
}
