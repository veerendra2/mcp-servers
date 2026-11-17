# syntax=docker/dockerfile:1@sha256:4edf897a3ffa55b89f906fc8cc78afdb3f1834cc9c7083565e611a8a7d5fe99e

FROM msteams_base

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends novnc websockify x11vnc \
    && rm -rf /var/lib/apt/lists/*

COPY --chmod=755 login.sh /usr/local/bin/msteams-login

USER pwuser

ENTRYPOINT ["/usr/local/bin/msteams-login"]
