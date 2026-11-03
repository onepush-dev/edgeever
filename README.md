# EdgeEver on Railway

One-click Railway template for [EdgeEver](https://github.com/tianma-if/edgeever) — an AI-native, self-hosted notes app and Evernote/Obsidian alternative with instant multi-device sync and a native Remote MCP server.

Deploy button: _added after the template is generated_

## What this repo contains

- `Dockerfile` — `FROM ghcr.io/tianma-if/edgeever:v2.18.0` (official image, pinned by digest; app unchanged). Built by GitHub Actions to `ghcr.io/onepush-dev/edgeever:v2.18.0`.
- `railway/railway-start.sh` — Railway volumes mount root-owned while EdgeEver runs as `bun` (UID 1000), so the wrapper chowns `/data` once and starts upstream's server as `bun` via su-exec on Railway's port 8080.

## Service

One service, `EdgeEver` (Bun + SQLite), volume `/data` (SQLite DB, `edgeever-secrets.json`, `resources/` attachments), health check `/api/health`.

## Variables

| Variable | Default |
|---|---|
| `EDGE_EVER_AUTH_PASSWORD` | `${{secret(32)}}` — initial `admin` password, generated per deploy (see the service's Variables tab) |

Baked defaults (override in Variables if needed): `EDGE_EVER_AUTH_USERNAME=admin`, `EDGE_EVER_DATA_DIR=/data`, `PORT=8080`. Optional: `EDGE_EVER_STORAGE_BACKEND=s3` + `EDGE_EVER_S3_*` for S3/R2 attachments, `EDGE_EVER_SESSION_TTL_DAYS`, `EDGE_EVER_CREDENTIALS_ENCRYPTION_KEY`. AI providers are configured inside the app (optional).

## First run

Open the public URL, sign in as `admin` with `EDGE_EVER_AUTH_PASSWORD`. Create member accounts in Profile → User accounts; create MCP tokens in Profile → API / MCP.

## License

EdgeEver is AGPL-3.0-only. Corresponding source: upstream [tianma-if/edgeever v2.18.0](https://github.com/tianma-if/edgeever/tree/v2.18.0) plus this repo's wrapper files.
