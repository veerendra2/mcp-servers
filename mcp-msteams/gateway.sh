#!/bin/sh
set -eu

api_key=$(sed -n 's/^MSTEAMS_MCP_API_KEY=//p' /run/secrets/msteams_env)

case "$api_key" in
  replace-with-a-long-random-value|""|*[!A-Za-z0-9_-]*)
    echo "MSTEAMS_MCP_API_KEY must be a single random value" >&2
    exit 1
    ;;
esac

if [ "${#api_key}" -lt 32 ]; then
  echo "MSTEAMS_MCP_API_KEY must contain at least 32 characters" >&2
  exit 1
fi

umask 077
printf '%s\n' "$api_key" >/tmp/msteams_api_key

exec supergateway "$@"
