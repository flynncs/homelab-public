# stacks

one directory per Komodo-managed stack.

## hosts

| stack | host | services |
|---|---|---|
| [`arr/core`](arr/core/) | `apps-vm-1` (`201`, `.51`) | Sonarr, Radarr, Prowlarr, Byparr, Profilarr, Maintainerr, Cleanuparr |
| [`arr/requests`](arr/requests/) | `apps-vm-1` (`201`, `.51`) | Seerr |
| [`arr/usenet-downloaders`](arr/usenet-downloaders/) | `apps-vm-1` (`201`, `.51`) | SABnzbd |
| [`arr/vpn-downloaders`](arr/vpn-downloaders/) | `apps-vm-1` (`201`, `.51`) | Gluetun and qBittorrent |
| [`music`](music/) | `apps-vm-1` (`201`, `.51`) | Lidarr, slskd, DroppedNeedle, Explo, Aurral, MusicGrabber, Soulbeet, Koito, multi-scrobbler, octo-fiesta |
| [`bookorbit`](bookorbit/) | `apps-vm-1` (`201`, `.51`) | BookOrbit and PostgreSQL |
| [`auth`](auth/) | `auth-vm-1` (`202`, `.53`) | pocket-id, lldap and tinyauth |
| [`jellyfin`](jellyfin/) | `jellyfin-ct` (`203`, `.40`) | Jellyfin with iGPU access |
| [`navidrome`](navidrome/) | `jellyfin-ct` (`203`, `.40`) | Navidrome |
| [`immich`](immich/) | `immich-ct` (`204`, `.41`) | Immich, machine learning, Valkey and PostgreSQL |
| [`edge`](edge/) | `edge-ct` (`205`, `.42`) | newt |
| [`bento`](bento/) | `apps-ct` (`206`, `.43`) | BentoPDF |
| [`tandoor`](tandoor/) | `apps-ct` (`206`, `.43`) | Tandoor and PostgreSQL |
| [`norish`](norish/) | `apps-ct` (`206`, `.43`) | Norish, PostgreSQL, Redis and Chrome |
| [`adguard`](adguard/) | `adguard-ct` (`207`, `.44`) | Pi-hole |
| [`rp`](rp/) | `rp-ct` (`208`, `.45`) | Caddy |
| [`syncthing`](syncthing/) | `mgmt-vm` (`200`, `.50`) | Syncthing |

## secrets

copy the environment template beside the selected stack:

```bash
cp stacks/<name>/.env.example stacks/<name>/.env
```

`.env` files are ignored and must not be committed. SOPS-encrypted environment
files can be loaded through Komodo's `compose_cmd_wrapper`.

## komodo

each `komodo.toml` defines the repository, host, compose path, webhook and
deployment settings. import `komodo/resources.toml` through a Komodo ResourceSync
after configuring the servers.

the server names correspond to the Ansible inventory and OpenTofu resources.
