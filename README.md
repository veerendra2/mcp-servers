# MCP Servers

My collection of MCP servers in Docker.

Model Context Protocol (MCP) servers let AI clients use tools and retrieve
context from external systems. These services are exposed on localhost only.

| MCP Server                               | Project Repo                                                                          | Endpoint                     |
| ---------------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------- |
| [mcp-atlassian](./mcp-atlassian)         | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian)                 | `http://127.0.0.1:20129/mcp` |
| [mcp-elasticsearch](./mcp-elasticsearch) | [cr7258/elasticsearch-mcp-server](https://github.com/cr7258/elasticsearch-mcp-server) | `http://127.0.0.1:20130/mcp` |
| [mcp-grafana](./mcp-grafana)             | [grafana/mcp-grafana](https://github.com/grafana/mcp-grafana)                         | `http://127.0.0.1:20131/mcp` |
| [mcp-kibana](./mcp-kibana)               | [TocharianOU/mcp-server-kibana](https://github.com/TocharianOU/mcp-server-kibana)     | `http://127.0.0.1:20132/mcp` |
| [mcp-msteams](./mcp-msteams)             | [m0nkmaster/msteams-mcp](https://github.com/m0nkmaster/msteams-mcp)                   | `http://127.0.0.1:20133/mcp` |

Create each ignored `.env` file from its example:

```sh
cp mcp-atlassian/.env.example mcp-atlassian/.env
cp mcp-elasticsearch/.env.example mcp-elasticsearch/.env
cp mcp-grafana/.env.example mcp-grafana/.env
cp mcp-kibana/.env.example mcp-kibana/.env
cp mcp-msteams/.env.example mcp-msteams/.env
```

Fill in the required values before starting the servers.

Start all servers with:

```sh
./deploy.sh

# Remove
./destroy.sh
```

## Coding Agents Configuration

<details>
  <summary>Codex</summary>

  Add below config in `~/.codex/config.toml`

  ```toml
  ...
  [mcp_servers]

  [mcp_servers.grafana]
  url = "http://127.0.0.1:20131/mcp"

  [mcp_servers.atlassian]
  url = "http://127.0.0.1:20129/mcp"

  [mcp_servers.elasticsearch]
  url = "http://127.0.0.1:20130/mcp"

  [mcp_servers.kibana]
  url = "http://127.0.0.1:20132/mcp"

  [mcp_servers.msteams]
  url = "http://127.0.0.1:20133/mcp"
  bearer_token_env_var = "MSTEAMS_MCP_API_KEY"
  ...
```
</details>


<details>
  <summary>GitHub Copilot CLI</summary>

Add to `~/.copilot/mcp-config.json`:

```json
{
  "mcpServers": {
    "grafana": {
      "type": "http",
      "url": "http://127.0.0.1:20131/mcp",
      "tools": ["*"]
    },
    "atlassian": {
      "type": "http",
      "url": "http://127.0.0.1:20129/mcp",
      "tools": ["*"]
    },
    "elasticsearch": {
      "type": "http",
      "url": "http://127.0.0.1:20130/mcp",
      "tools": ["*"]
    },
    "kibana": {
      "type": "http",
      "url": "http://127.0.0.1:20132/mcp",
      "tools": ["*"]
    },
    "msteams": {
      "type": "http",
      "url": "http://127.0.0.1:20133/mcp",
      "headers": {
        "Authorization": "Bearer ${MSTEAMS_MCP_API_KEY}"
      },
      "tools": ["*"]
    }
  }
}
```

Check with `copilot mcp list`.

</details>

<details>
  <summary>Pi</summary>

Add to `~/.pi/agent/mcp.json`:

```json
{
  "mcpServers": {
    "grafana": {
      "type": "http",
      "url": "http://127.0.0.1:20131/mcp"
    },
    "atlassian": {
      "type": "http",
      "url": "http://127.0.0.1:20129/mcp"
    },
    "elasticsearch": {
      "type": "http",
      "url": "http://127.0.0.1:20130/mcp"
    },
    "kibana": {
      "type": "http",
      "url": "http://127.0.0.1:20132/mcp"
    },
    "msteams": {
      "type": "http",
      "url": "http://127.0.0.1:20133/mcp",
      "headers": {
        "Authorization": "Bearer ${MSTEAMS_MCP_API_KEY}"
      }
    }
  }
}
```

Check with `pi mcp list`; run `/reload` inside an existing Pi session after editing.
Pi supports streamable HTTP here and does not support legacy SSE entries.

</details>

<details>
  <summary>Claude Code</summary>

For user scope, add to `~/.claude.json`:

```json
{
  "mcpServers": {
    "grafana": {
      "type": "http",
      "url": "http://127.0.0.1:20131/mcp"
    },
    "atlassian": {
      "type": "http",
      "url": "http://127.0.0.1:20129/mcp"
    },
    "elasticsearch": {
      "type": "http",
      "url": "http://127.0.0.1:20130/mcp"
    },
    "kibana": {
      "type": "http",
      "url": "http://127.0.0.1:20132/mcp"
    },
    "msteams": {
      "type": "http",
      "url": "http://127.0.0.1:20133/mcp",
      "headers": {
        "Authorization": "Bearer ${MSTEAMS_MCP_API_KEY}"
      }
    }
  }
}
```

Check with `claude mcp list` or `claude mcp get grafana`.

</details>
