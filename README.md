# MCP Servers

My collection of MCP servers in Docker.

Model Context Protocol (MCP) servers let AI clients use tools and retrieve
context from external systems. These services are exposed on localhost only.

| MCP Server                               | Project Repo                                                                          | Endpoint                     |
| ---------------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------- |
| [mcp-atlassian](./mcp-atlassian)         | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian)                 | `http://127.0.0.1:20129/sse` |
| [mcp-elasticsearch](./mcp-elasticsearch) | [cr7258/elasticsearch-mcp-server](https://github.com/cr7258/elasticsearch-mcp-server) | `http://127.0.0.1:20130/mcp` |
| [mcp-grafana](./mcp-grafana)             | [grafana/mcp-grafana](https://github.com/grafana/mcp-grafana)                         | `http://127.0.0.1:20131/mcp` |
| [mcp-kibana](./mcp-kibana)               | [TocharianOU/mcp-server-kibana](https://github.com/TocharianOU/mcp-server-kibana)     | `http://127.0.0.1:20132/mcp` |

Create each ignored `.env` file from its example:

```sh
cp mcp-atlassian/.env.example mcp-atlassian/.env
cp mcp-elasticsearch/.env.example mcp-elasticsearch/.env
cp mcp-grafana/.env.example mcp-grafana/.env
cp mcp-kibana/.env.example mcp-kibana/.env
```

Fill in the required values before starting the servers.

Start all servers with:

```sh
./deploy.sh
```
