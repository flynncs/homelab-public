# arr core

indexer management, TV and movie automation, profiles, and download cleanup on
`apps-vm-1`.

## services

| service | port | role |
|---|---:|---|
| Prowlarr | `9696` | indexer configuration shared with Sonarr and Radarr |
| Sonarr | `8989` | TV monitoring, import and library management |
| Radarr | `7878` | movie monitoring, import and library management |
| Byparr | `8191` | anti-bot request proxy for indexers that need it |
| Profilarr | `6868` | quality profile and custom format management |
| Maintainerr | `6246` | media collection and retention rules |
| Cleanuparr | `11011` | stalled download and failed import cleanup |

Prowlarr sends indexers to Sonarr and Radarr. Sonarr and Radarr send downloads to
qBittorrent and SABnzbd in the sibling downloader stacks, then import completed
files through the shared `/data` view.

## storage

| host path | container path | used by |
|---|---|---|
| `/data/config/<service>` | service config path | all stateful services |
| `/mnt/data` | `/data` | Sonarr and Radarr |

Sonarr, Radarr and the downloaders must use the same container paths for imports
and hardlinks to work.

## first deploy

1. add Sonarr and Radarr applications in Prowlarr.
2. add qBittorrent at `http://10.20.0.51:8080` and SABnzbd at
   `http://10.20.0.51:8181` in Sonarr and Radarr.
3. set root folders under `/data/media`.
4. add Sonarr, Radarr and qBittorrent to Cleanuparr using their API keys.

Cleanuparr stores its connection data under `/data/config/cleanuparr`. SABnzbd
failed-import handling remains in Sonarr and Radarr.
