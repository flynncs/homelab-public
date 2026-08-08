# routes

Generated from `services/routes.yaml` and Ansible inventory by `scripts/gen-routes.js`.

## caddy routes

| Service | Public hosts | Internal hosts | Upstream | External |
|---|---|---|---|---|
| `jellyfin` | `jelly.home.example` | `jelly.internal.home.example` | `jellyfin-ct:8096 (http://10.20.0.40:8096)` | yes |
| `navidrome` | `music.home.example` | `music.internal.home.example` | `jellyfin-ct:4533 (http://10.20.0.40:4533)` | yes |
| `requests` | `requests.home.example` | - | `apps-vm-1:5055 (http://10.20.0.51:5055)` | yes |
| `photos` | `photos.home.example` | `photos.internal.home.example` | `immich-ct:2283 (http://10.20.0.41:2283)` | yes |
| `auth` | `auth.home.example` | - | `auth-vm-1:3055 (http://10.20.0.53:3055)` | yes |
| `recipes` | `recipes.home.example` | `recipes.internal.home.example` | `apps-ct:8089 (http://10.20.0.43:8089)` | yes |
| `droppedneedle` | `groove.home.example` | `droppedneedle.internal.home.example` | `apps-vm-1:8688 (http://10.20.0.51:8688)` | yes |
| `octo-fiesta` | `octo.music.home.example` | `octo-fiesta.internal.home.example` | `apps-vm-1:5274 (http://10.20.0.51:5274)` | yes |
| `proxmox` | `proxmox.home.example` | `proxmox.internal.home.example` | `https://10.20.0.1:8006` | yes |
| `komodo` | `komodo.home.example` | `komodo.internal.home.example` | `mgmt-vm:9120 (http://10.20.0.50:9120)` | yes |
| `lldap` | `lldap.home.example` | `lldap.internal.home.example` | `auth-vm-1:17170 (http://10.20.0.53:17170)` | yes |
| `sonarr` | - | `sonarr.internal.home.example` | `apps-vm-1:8989 (http://10.20.0.51:8989)` | no |
| `radarr` | - | `radarr.internal.home.example` | `apps-vm-1:7878 (http://10.20.0.51:7878)` | no |
| `cleanuparr` | - | `cleanuparr.internal.home.example` | `apps-vm-1:11011 (http://10.20.0.51:11011)` | no |
| `lidarr` | - | `lidarr.internal.home.example` | `apps-vm-1:8686 (http://10.20.0.51:8686)` | no |
| `slskd` | - | `slskd.internal.home.example` | `apps-vm-1:5030 (http://10.20.0.51:5030)` | no |
| `explo` | - | `explo.internal.home.example` | `apps-vm-1:7288 (http://10.20.0.51:7288)` | no |
| `explo-user-b` | - | `explo-user-b.internal.home.example` | `apps-vm-1:7289 (http://10.20.0.51:7289)` | no |
| `aurral` | - | `aurral.internal.home.example` | `apps-vm-1:3001 (http://10.20.0.51:3001)` | no |
| `musicgrabber` | - | `musicgrabber.internal.home.example` | `apps-vm-1:38274 (http://10.20.0.51:38274)` | no |
| `soulbeet` | - | `soulbeet.internal.home.example` | `apps-vm-1:9765 (http://10.20.0.51:9765)` | no |
| `koito` | - | `koito.internal.home.example` | `apps-vm-1:4110 (http://10.20.0.51:4110)` | no |
| `koito-user-b` | - | `koito-user-b.internal.home.example` | `apps-vm-1:4111 (http://10.20.0.51:4111)` | no |
| `multi-scrobbler` | - | `multi-scrobbler.internal.home.example` | `apps-vm-1:9078 (http://10.20.0.51:9078)` | no |
| `prowlarr` | - | `prowlarr.internal.home.example` | `apps-vm-1:9696 (http://10.20.0.51:9696)` | no |
| `sabnzbd` | - | `sabnzbd.internal.home.example` | `apps-vm-1:8181 (http://10.20.0.51:8181)` | no |
| `qbittorrent` | - | `qbittorrent.internal.home.example` | `apps-vm-1:8080 (http://10.20.0.51:8080)` | no |
| `bentopdf` | - | `bentopdf.internal.home.example` | `apps-ct:3000 (http://10.20.0.43:3000)` | no |
| `bookorbit` | `books.home.example` | `books.internal.home.example` | `apps-vm-1:3000 (http://10.20.0.51:3000)` | yes |
| `pihole` | - | `pihole.internal.home.example` | `adguard-ct:80 (http://10.20.0.44:80)` | no |
| `tinyauth` | - | `tinyauth.internal.home.example` | `auth-vm-1:3001 (http://10.20.0.53:3001)` | no |
| `profilarr` | - | `profilarr.internal.home.example` | `apps-vm-1:6868 (http://10.20.0.51:6868)` | no |
| `syncthing` | - | `syncthing.internal.home.example` | `mgmt-vm:8384 (http://10.20.0.50:8384)` | no |

## split DNS

Router DHCP DNS should point clients at `192.0.2.10`.
Tailscale split DNS for `internal.home.example` should point at `100.64.0.10`.

| Domain | Answer | Note |
|---|---|---|
| `pangolin.home.example` | `198.51.100.20` | remote VPS; bypasses local Caddy |
| `*.home.example` | `192.0.2.10` | Proxmox LAN IP; host DNAT forwards :80/:443 to rp-ct |
| `*.internal.home.example` | `192.0.2.10` | Proxmox LAN IP; host DNAT forwards :80/:443 to rp-ct |
