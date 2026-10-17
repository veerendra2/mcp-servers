# Repository instructions

This repository contains small Docker Compose deployments for local MCP
(Model Context Protocol) servers. Keep changes focused on the server they
touch and preserve the existing directory layout.

## Compose conventions

- Keep one `compose.yaml` in each `mcp-*` directory.
- Keep credentials only in that directory's ignored `.env` file. Never commit,
  print, or copy secret values. Keep non-secret placeholders and variable names
  in that directory's `.env.example` file.
- Publish each server on a dedicated `127.0.0.1` host port. Containers may
  listen on `0.0.0.0:8000` internally, but must not be exposed beyond the
  local host.
- Keep containers hardened and read-only: use `read_only: true`,
  `cap_drop: [ALL]`, and `security_opt: [no-new-privileges:true]`.
- Preserve service-specific read-only or high-risk-operation safeguards such
  as `--disable-write=true` and `DISABLE_HIGH_RISK_OPERATIONS=true`.
- Add only mounts, host entries, capabilities, or privileges that the service
  demonstrably needs.

Projects:

- [mcp-atlassian](./mcp-atlassian)
- [mcp-elasticsearch](./mcp-elasticsearch)
- [mcp-grafana](./mcp-grafana)
- [mcp-kibana](./mcp-kibana)

## Documentation and startup

- Keep `README.md` short: explain MCP in one sentence, list each server in a
  table, show its endpoint, and document how to copy each `.env.example` file
  to `.env`.
- Keep the root `deploy.sh` short and make it run `docker compose up -d` in every
  `mcp-*` directory with a `compose.yaml`.

## Validation

For Compose or script changes, run:

```sh
for directory in mcp-*/; do
  (cd "$directory" && docker compose config -q)
done
sh -n deploy.sh
git diff --check
```

Do not start containers during validation unless the user explicitly asks for
a runtime check.
