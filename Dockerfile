# EdgeEver on Railway: the official image (pinned by digest), unchanged app, plus a
# tiny start wrapper. Railway volumes mount root-owned, while the image runs as the
# non-root `bun` user (UID 1000), so the wrapper fixes /data ownership once and then
# drops to `bun` with su-exec before starting upstream's server.
FROM ghcr.io/tianma-if/edgeever:v2.18.0@sha256:06d9518f1bc9848361b3eaa52199029800938aafaa5527112375557fd72776ae
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/edgeever" \
      org.opencontainers.image.licenses="AGPL-3.0-only"
USER root
RUN apk add --no-cache su-exec
COPY --chmod=755 railway/railway-start.sh /app/railway-start.sh
ENV PORT=8080 \
    EDGE_EVER_DATA_DIR=/data \
    EDGE_EVER_AUTH_USERNAME=admin \
    EDGE_EVER_DEPLOYMENT_METHOD=railway
EXPOSE 8080
HEALTHCHECK NONE
CMD ["sh", "/app/railway-start.sh"]
