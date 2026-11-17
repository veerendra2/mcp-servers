#!/bin/sh
set -eu

Xvfb :99 -screen 0 1440x900x24 -nolisten tcp >/tmp/xvfb.log 2>&1 &

ready=false
for _ in $(seq 1 50); do
  if [ -S /tmp/.X11-unix/X99 ]; then
    ready=true
    break
  fi
  sleep 0.1
done

if [ "$ready" != true ]; then
  cat /tmp/xvfb.log >&2
  echo "Xvfb did not start" >&2
  exit 1
fi

x11vnc -display :99 -forever -shared -nopw -localhost -rfbport 5900 \
  >/tmp/x11vnc.log 2>&1 &
websockify --web=/usr/share/novnc 6080 localhost:5900 \
  >/tmp/websockify.log 2>&1 &

exec node /app/dist/cli.js login --force
