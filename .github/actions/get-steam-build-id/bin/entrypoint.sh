#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

appid="${1:-}"
branch="${2:-}"

if [[ ! "$appid" =~ ^[0-9]+$ ]]; then
  echo "app id is invalid" >&2
  exit 1
fi

if [[ -z "$branch" ]]; then
  echo "branch is invalid" >&2
  exit 1
fi

export PATH="/usr/games:$PATH"

timeout --kill-after=330 300 unbuffer steamcmd -tcp +login anonymous +quit

build_id="$(
  timeout --kill-after=330 300 \
    steamcmd -tcp +login anonymous +app_info_print "$appid" +quit \
    | sed -n "/AppID : $appid/,\$p" \
    | tail -n +2 \
    | "$SCRIPT_DIR/vdf-to-json" \
    | jq \
      --arg appId "$appid" \
      --arg branch "$branch" \
      '.[$appId].depots.branches[$branch].buildid'
)"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "build-id=$build_id" >> "$GITHUB_OUTPUT"
else
  echo "$build_id"
fi
