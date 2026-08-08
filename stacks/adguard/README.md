# pihole

local DNS and split-horizon resolution on `adguard-ct`.

the stack name and host remain `adguard` for Terraform and Komodo state. the
container itself is Pi-hole.

## service

| service | image | ports |
|---|---|---|
| `pihole` | `pihole/pihole:2026.07.2` | DNS `53/tcp`, `53/udp`; web `80/tcp` |

Pi-hole forwards upstream queries to Quad9 with DNSSEC enabled. queries from LAN
clients arrive through dnsmasq on the Proxmox host with EDNS Client Subnet data,
which Pi-hole uses for per-client reporting before stripping it upstream.

```text
LAN client -> Proxmox dnsmasq -> Pi-hole -> Quad9
              adds ECS           strips ECS
```

## split DNS

| name | answer |
|---|---|
| `pangolin.home.example` | `198.51.100.20` |
| `*.home.example` | `192.0.2.10` |
| `*.internal.home.example` | `192.0.2.10` |

the Pangolin name resolves directly to the remote endpoint. service names point
at the Proxmox LAN address, which forwards web traffic to Caddy on `rp-ct`.

## storage and config

| path | contents |
|---|---|
| `/data/config/pihole` | Pi-hole database and configuration |

`PIHOLE_WEBPASSWORD` is loaded from `.env`. the dashboard is available at
`https://pihole.internal.home.example/admin/`.

set the router DHCP DNS server to `192.0.2.10`, then renew client leases.

```bash
dig @192.0.2.10 example.com A
dig @192.0.2.10 pihole.internal.home.example A
dig @192.0.2.10 pangolin.home.example A
dig +tcp @192.0.2.10 example.com A
```
