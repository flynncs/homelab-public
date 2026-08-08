# jellyfin

media server on `jellyfin-ct` with Intel GPU access.

## service

| service | image | ports |
|---|---|---|
| `jellyfin` | `lscr.io/linuxserver/jellyfin:latest` | HTTP `8096`, HTTPS `8920` |

the container receives `/dev/dri` from the LXC for hardware transcoding. Caddy
uses port `8096` as its upstream.

## storage

| host path | container path | access |
|---|---|---|
| `/opt/jellyfin/config` | `/config` | read/write |
| `/opt/jellyfin/data` | `/data` | read/write |
| `/mnt/media` | `/media` | read/write |

the media mount is writable so Jellyfin and Maintainerr can remove items through
the Jellyfin API. run the container as UID/GID `1000:1000` and give that account
access to the video and render device groups.

## first deploy

1. add libraries from `/media`.
2. enable Intel Quick Sync or VAAPI transcoding.
3. select the render device under `/dev/dri`.
4. test a hardware transcode and confirm activity on the host GPU.
