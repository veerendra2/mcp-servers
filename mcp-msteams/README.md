# Microsoft Teams MCP

This container builds the upstream
[`m0nkmaster/msteams-mcp`](https://github.com/m0nkmaster/msteams-mcp) release
`v0.31.0`. Supergateway exposes its stdio transport as Streamable HTTP.

First-time login needs a visible browser inside the container. This one-time
Docker login stores the encrypted session data in the `mcp_msteams_data`
volume; after login, start the MCP server.

## API key

1. Create the ignored environment file:

```sh
cp .env.example .env
```

2. Generate a key with `openssl rand -hex 32` and use it as the
   `MSTEAMS_MCP_API_KEY` value in `.env`.

3. Export the same key before starting a coding agent:

```sh
set -a
. ./.env
set +a
```

`deploy.sh` and Docker Compose read `.env` as the secret file automatically.
Exporting the key is only required for coding-agent processes. The MCP endpoint
rejects requests without this key; client examples are in the
[root README](../README.md#coding-agents-configuration).

The normal endpoint exposes an explicit read-only tool allowlist. Login,
message changes, reactions, favourites/bookmarks changes, read-state changes,
assignment actions, group-chat creation, and file downloads are unavailable.
`teams_get_thread` remains available but rejects `markRead: true`.

## Login

1. Start the temporary browser-based login container:

```bash
docker compose --profile login up --build mcp-msteams-login
```

2. While that command is running, open: http://127.0.0.1:6080/vnc.html?autoconnect=1&resize=scale

3. Complete Microsoft sign-in and MFA in the Firefox window. Wait for the login container to stop after authentication succeeds. The session is stored in the shared Docker volume.

4. Optionally verify the saved session:

```bash
docker compose run --rm --no-deps --entrypoint node mcp-msteams /app/dist/cli.js status
```

5. Start the MCP server:

```bash
docker compose up -d
```

Endpoint: `http://127.0.0.1:20133/mcp`

## Notes

- The upstream server includes tools that can send, edit, and delete Teams
  messages, but the normal MCP endpoint does not expose them. Keep the API key
  limited to trusted clients because it still grants access to Teams data.
- Automatic token refresh remains enabled. If Microsoft requires interactive
  authentication, repeat the login steps above.
- Session files are encrypted using the container hostname and user. Always use
  this Compose service for login and normal operation.
- The noVNC login page has no password and is intentionally bound to
  `127.0.0.1`; do not expose port `6080` beyond the local host.
- Treat `mcp_msteams_data` as credential material. Restrict Docker access, keep
  host-disk encryption enabled, and encrypt any necessary volume backup.
- Do not run `docker compose down -v`; it deletes the authenticated session.
- If the volume may be compromised, revoke the Microsoft session, delete the
  volume, generate a new MCP API key, and log in again.
- To log in again later, first run `docker compose stop mcp-msteams`, then
  repeat the login steps above.
