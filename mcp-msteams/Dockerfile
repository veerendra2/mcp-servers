# syntax=docker/dockerfile:1@sha256:4edf897a3ffa55b89f906fc8cc78afdb3f1834cc9c7083565e611a8a7d5fe99e

FROM mcr.microsoft.com/playwright:v1.58.0-noble@sha256:35c7d48b4ccaf3aca5018f5f1bf7f50c7da7d61d176c530741f4f2e9ca336c34

WORKDIR /app

ADD https://github.com/m0nkmaster/msteams-mcp/archive/refs/tags/v0.32.0.tar.gz /tmp/msteams-mcp.tar.gz

COPY apply-readonly-patch.mjs /tmp/apply-readonly-patch.mjs

RUN tar -xzf /tmp/msteams-mcp.tar.gz --strip-components=1 \
    && node /tmp/apply-readonly-patch.mjs \
    && rm /tmp/msteams-mcp.tar.gz /tmp/apply-readonly-patch.mjs \
    && npm ci \
    && npm run build \
    && npm prune --omit=dev \
    && npm install -g --no-fund --no-audit supergateway@4.2.2 \
    && npm cache clean --force

ENV TEAMS_BROWSER=firefox

COPY --chmod=755 gateway.sh /usr/local/bin/msteams-gateway

RUN mkdir -p /home/pwuser/.teams-mcp-server \
    && chown -R pwuser:pwuser /home/pwuser/.teams-mcp-server

USER pwuser

ENV NODE_ENV=production

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/msteams-gateway"]
