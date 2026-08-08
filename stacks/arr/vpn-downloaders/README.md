# vpn downloader

qBittorrent routed through a Proton WireGuard connection managed by Gluetun.

## services

| service | role |
|---|---|
| Gluetun | WireGuard tunnel, firewall and Proton port forwarding |
| qBittorrent | torrent client using Gluetun's network namespace |

qBittorrent has `network_mode: service:gluetun`, so it has no independent network
interface or published ports. Gluetun publishes the qBittorrent web UI on `8080`.
all qBittorrent traffic stops if the VPN container is unavailable.

Gluetun receives the forwarded Proton port and updates qBittorrent through its
localhost API on every connect and disconnect.

## storage and config

| path | contents |
|---|---|
| `/data/config/qbittorrent` | qBittorrent config |
| `/mnt/data/torrents` | incomplete and completed torrent data |

`WIREGUARD_PRIVATE_KEY` is required in `.env`. the VPN country is set in
`compose.yaml`.

## first deploy

enable qBittorrent's localhost authentication bypass under **Web UI →
Authentication**. Gluetun's port update commands use the localhost API from the
shared network namespace.
