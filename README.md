# MCP Servers

My collection of MCP servers in Docker.

Model Context Protocol (MCP) servers let AI clients use tools and retrieve
context from external systems. These services are exposed on localhost only.

| Project                                  | Endpoint                     |
| ---------------------------------------- | ---------------------------- |
| [mcp-atlassian](./mcp-atlassian)         | `http://127.0.0.1:20129/sse` |
| [mcp-elasticsearch](./mcp-elasticsearch) | `http://127.0.0.1:20130/mcp` |
| [mcp-grafana](./mcp-grafana)             | `http://127.0.0.1:20131/mcp` |

Create each ignored `.env` file from its example:

```sh
cp mcp-atlassian/.env.example mcp-atlassian/.env
cp mcp-elasticsearch/.env.example mcp-elasticsearch/.env
cp mcp-grafana/.env.example mcp-grafana/.env
```

Fill in the required values before starting the servers.

Start all servers with:

```sh
./deploy.sh
```
