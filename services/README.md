# service routes

`routes.yaml` is the source for Caddy routes, split DNS documentation and
Proxmox forwarding rules.

## service fields

| field | purpose |
|---|---|
| `name` | stable service identifier |
| `upstream_host` | hostname from the Ansible inventory |
| `upstream_port` | service port on that host |
| `upstream` | complete upstream URL when inventory resolution is not used |
| `public_hosts` | names routed through Caddy and the remote tunnel |
| `internal_hosts` | names routed through Caddy on the local network |
| `external` | marks services expected to be reachable through Pangolin |
| `caddy` | per-route transport, header and flush settings |

the `entrypoints` section defines the LAN and Tailscale interfaces. the
`internal` targets resolve `adguard-ct` and `rp-ct` through the Ansible inventory.

## generation

```bash
npm run gen:routes
```

the generator writes:

- `stacks/rp/Caddyfile`
- `docs/routes.md`
- `docs/proxmox-lan-dnat-rules.v4`

```bash
npm run check:routes
```

the check exits non-zero when a generated file differs from `routes.yaml` or the
inventory.
