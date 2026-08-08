# navidrome

Subsonic-compatible music server on `jellyfin-ct`.

| service | image | port |
|---|---|---:|
| `navidrome` | `deluan/navidrome:latest` | `4533` |

## storage

| host path | container path | access |
|---|---|---|
| `/opt/navidrome/data` | `/data` | read/write database and cache |
| `/mnt/media/music` | `/music` | read-only library |

Navidrome scans the library hourly. ListenBrainz support points at
multi-scrobbler on `apps-vm-1:9078`, which fans listening events out to the
configured scrobble services.

create the first admin account through the web UI, add `/music` as the library,
then configure any Subsonic clients against `https://music.home.example`.
