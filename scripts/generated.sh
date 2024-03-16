#!/usr/bin/env zsh

set -e # Exit immediately if a command exits with a non-zero status
set -x # Print each command before executing it

if ! command -v flutter &> /dev/null; then
    echo "Error: flutter not found in PATH" >&2
    exit 1
fi

flutter pub run build_runner watch --delete-conflicting-outputs
