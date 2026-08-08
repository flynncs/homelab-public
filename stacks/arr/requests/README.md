# seerr

request and discovery frontend for the Jellyfin library.

## service

| service | image | port | config |
|---|---|---:|---|
| `seerr` | `ghcr.io/seerr-team/seerr:latest` | `5055` | `/data/config/jellyseerr` |

Seerr reads the Jellyfin library and sends approved TV and movie requests to
Sonarr and Radarr. its health check uses `/api/v1/status`.

## first deploy

1. sign in through Jellyfin.
2. add the Jellyfin server and libraries.
3. add Sonarr at `http://10.20.0.51:8989`.
4. add Radarr at `http://10.20.0.51:7878`.
5. select the matching root folders and quality profiles.
