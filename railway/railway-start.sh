#!/bin/sh
# Railway start wrapper for EdgeEver: make the Railway volume writable for the
# image's `bun` user (UID/GID 1000), then run upstream's server as that user.
set -eu
DATA="${EDGE_EVER_DATA_DIR:-/data}"
mkdir -p "$DATA"
if [ "$(stat -c %u "$DATA")" != "1000" ]; then
  echo "[railway] chowning $DATA to bun (1000:1000)"
  chown -R 1000:1000 "$DATA"
fi
: "${EDGE_EVER_AUTH_USERNAME:=admin}"
export EDGE_EVER_AUTH_USERNAME
echo "[railway] starting EdgeEver on port ${PORT}, data in ${DATA}"
cd /app
exec su-exec bun:bun bun scripts/self-hosted-server.js
