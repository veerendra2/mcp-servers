# Microsoft Teams MCP

This container builds the upstream
[`m0nkmaster/msteams-mcp`](https://github.com/m0nkmaster/msteams-mcp) release
`v0.31.0`. Supergateway exposes its stdio transport as Streamable HTTP.

Use this one-time Docker login to save an authenticated session in the
`mcp_msteams_data` volume, then start the MCP server.

## Login

No host packages or X11 server are required.

1. From the repository root, enter the Teams MCP directory:

```sh
cd mcp-msteams
```

2. Start the temporary browser-based login container:

```sh
docker compose --profile login up --build mcp-msteams-login
```

3. While that command is running, open:

http://127.0.0.1:6080/vnc.html?autoconnect=1&resize=scale

4. Complete Microsoft sign-in and MFA in the Firefox window. Wait for the
   login container to stop after authentication succeeds. The session is stored
   in the shared Docker volume.

5. Optionally verify the saved session:

```sh
docker compose run --rm --no-deps \
  --entrypoint node \
  mcp-msteams /app/dist/cli.js status
```

6. Start the MCP server:

```sh
docker compose up -d
```

Endpoint: `http://127.0.0.1:20133/mcp`

## Notes

- The upstream server includes tools that can send, edit, and delete Teams
  messages. Only connect trusted MCP clients.
- Session files are encrypted using the container hostname and user. Always use
  this Compose service for login and normal operation.
- The noVNC login page has no password and is intentionally bound to
  `127.0.0.1`; do not expose port `6080` beyond the local host.
- Do not run `docker compose down -v`; it deletes the authenticated session.
- To log in again later, first run `docker compose stop mcp-msteams`, then
  repeat steps 2–6.
