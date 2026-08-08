# arr

the arr workload is split into four Komodo stacks so download clients and
request handling can be updated independently from the core applications.

| directory | services |
|---|---|
| `core/` | Prowlarr, Sonarr, Radarr, Cleanuparr and Profilarr |
| `requests/` | Seerr |
| `usenet-downloaders/` | SABnzbd |
| `vpn-downloaders/` | Gluetun and qBittorrent |

create the host configuration directories before the first deployment:

```bash
sudo mkdir -p /data/config/{prowlarr,sonarr,radarr,cleanuparr,profilarr,maintainerr,jellyseerr,sabnzbd,qbittorrent}
sudo chown -R 1000:1000 /data/config
```

the shared `/mnt/data` mount keeps download and media paths consistent between
the containers.
