#!/usr/bin/env bash

set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

for directory in "$root"/mcp-*/; do
  [ -f "$directory/compose.yaml" ] || continue
  (cd "$directory" && docker compose up -d)
done
