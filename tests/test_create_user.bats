#!/usr/bin/env bats

setup() {
     export TEST_TMPDIR="$BATS_TMPDIR"
    mkdir -p "$TEST_TMPDIR/bin"

    # Mock system commands (useradd, userdel)
    export USERADD_BIN="$TEST_TMPDIR/bin/useradd"
    cat > "$USERADD_BIN" <<'EOF'
#!/bin/bash
echo "MOCK useradd $*"
EOF
    chmod +x "$USERADD_BIN"

    export USERDEL_BIN="$TEST_TMPDIR/bin/userdel"
    cat > "$USERDEL_BIN" <<'EOF'
check_root() { return 0; }
log() { echo "MOCK LOG $*"; }
user_exists() { return 1; } # default: user does NOT exist
EOF

    export SCRIPT_DIR="$TEST_TMPDIR/utils_mock"

    # Source the script under test
    source "$(dirname "$BATS_TEST_FILENAME")/../scripts/create_user.sh"
}

teardown() {
    rm -f "$USERADD_BIN"
}

@test "create_user creates a new user successfully" {
    run create_user "testuser"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "User testuser created" ]]
}

@test "create_user fails, username already in use" {
    user_exists() { return 0; }
    run create_user "testuser"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "User testuser already exists" ]]
}

@test "create_user fails, useradd fails" {
    echo 'exit 1' > "$USERADD_BIN"
    run create_user "testuser"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Failed to create user testuser" ]]
}
