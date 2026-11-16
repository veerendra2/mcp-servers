FROM mcr.microsoft.com/playwright:v1.58.0-noble

WORKDIR /app

ADD https://github.com/m0nkmaster/msteams-mcp/archive/refs/tags/v0.31.0.tar.gz /tmp/msteams-mcp.tar.gz

RUN tar -xzf /tmp/msteams-mcp.tar.gz --strip-components=1 \
    && rm /tmp/msteams-mcp.tar.gz \
    && npm ci \
    && npm run build \
    && npm prune --omit=dev \
    && npm install -g --no-fund --no-audit supergateway@4.2.2 \
    && npm cache clean --force

ENV TEAMS_BROWSER=firefox

RUN mkdir -p /home/pwuser/.teams-mcp-server \
    && chown -R pwuser:pwuser /home/pwuser/.teams-mcp-server

USER pwuser

ENV NODE_ENV=production

EXPOSE 8000

ENTRYPOINT ["supergateway"]
