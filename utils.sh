#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# log LEVEL MESSAGE
# Prints a log message with a timestamp.
# LEVEL: INFO, DEBUG, WARN, ERROR
# MESSAGE: The message to log
log() {
  local level_of_log=$1
  shift
  local message="$*"
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  if [[ -z "$level_of_log" ]]; then
    echo "Missing log level" >&2
    return 1
  fi

  if [[ ! "$level_of_log" =~ ^(INFO|WARN|ERROR|DEBUG)$ ]]; then
    echo "Invalid log level: $level_of_log" >&2
    return 1
  fi

  if [[ $level_of_log == "ERROR" || $level_of_log == "WARN" ]]; then
    echo "[$timestamp] [$level_of_log] $message" >&2
    return
  fi

  echo "[$timestamp] [$level_of_log] $message"
}

# Checks if the script is run as root
# Returns 1 and prints an error if not root
check_root() {
  if [[ "$(get_euid)" -ne 0 ]]; then
    log ERROR This script must be run as root
    return 1
  fi
}

# user_exists USERNAME
# Checks if a user exists in the system using getent.
# USERNAME: the username to check
# return 0 if user exists, 1 if not
user_exists() {
  local username="$1"

  if getent passwd "$username" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

# Wrapper to get the effective user ID
# This allows mocking in tests
get_euid() {
  echo "$EUID"
}

get_username() {
  local username="${1:-}"
  if [[ -n "$username" ]]; then
    echo "$username"
    return
  fi
  read -r -p "Please enter username: " username
  echo "$username"
}

get_password() {
  local password="${1:-}"
  if [[ -n "$password" ]]; then
    echo "$password"
    return
  fi
  read -rs -p "Please enter password: " password
  echo
  echo "$password"

}
