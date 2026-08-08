# caddy reverse proxy

Caddy on `rp-ct`, handling local TLS and upstream routing for the service
registry.

## service

| service | image | ports |
|---|---|---|
| `caddy` | `ghcr.io/caddybuilds/caddy-cloudflare:latest` | HTTP `80`, HTTPS `443`, HTTP/3 `443/udp` |

the image includes the Cloudflare DNS provider. `CLOUDFLARE_API_TOKEN` needs DNS
edit access to the configured zone. certificates are stored in
`/data/config/caddy/data`; runtime config is stored in
`/data/config/caddy/config`.

## routing

```text
LAN client -> Pi-hole -> Caddy -> service
remote client -> Pangolin -> edge-ct -> service
```

`services/routes.yaml` is the route source. the generator resolves guest names
through the Ansible inventory and writes `stacks/rp/Caddyfile`.

```bash
npm run gen:routes
npm run check:routes
```

## validation and reload

```bash
docker run --rm -v "$PWD/Caddyfile:/c:ro" ghcr.io/caddybuilds/caddy-cloudflare:latest \
  caddy validate --config /c --adapter caddyfile

docker exec caddy caddy reload --config /etc/caddy/Caddyfile
```
