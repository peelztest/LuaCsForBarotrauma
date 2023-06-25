#!/usr/bin/env bash

# Make sure to login first with "docker login ghcr.io"
# The credentials are:
#   Username: your GitHub username
#   Password: a classic GitHub personal access token (PAT) with the write:packages permission

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR/.."

docker push get-steam-build-id:latest ghcr.io/peelztest/get-steam-build-id
