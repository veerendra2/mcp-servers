FROM node:22-slim

RUN npm install -g --no-fund --no-audit @tocharianou/mcp-server-kibana@0.11.1 \
    && npm cache clean --force

USER node

EXPOSE 8000

ENTRYPOINT ["mcp-server-kibana"]
