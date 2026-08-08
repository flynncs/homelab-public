# usenet downloader

SABnzbd downloader for Sonarr and Radarr.

## service

| service | image | host port | config | downloads |
|---|---|---:|---|---|
| `sabnzbd` | `lscr.io/linuxserver/sabnzbd:latest` | `8181` | `/data/config/sabnzbd/config` | `/mnt/data/usenet` |

the container sees its download tree as `/data/usenet`. Sonarr and Radarr see
the same files under `/data/usenet` through their `/mnt/data:/data` mount, so no
remote path mapping is required.

## first deploy

1. add the Usenet servers in SABnzbd.
2. set temporary and completed download paths under `/data/usenet`.
3. add SABnzbd at `http://10.20.0.51:8181` in Sonarr and Radarr.
4. use matching categories for the Sonarr and Radarr download clients.
