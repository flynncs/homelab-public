# music

music acquisition, library management, playlists and scrobbling on
`apps-vm-1`.

## services

| service | port | role |
|---|---:|---|
| Gluetun | `5030`, `5031` | Proton WireGuard network and forwarded Soulseek ports |
| slskd | through Gluetun | Soulseek client |
| Lidarr | `8686` | library monitoring and imports; nightly image for Tubifarry |
| DroppedNeedle | `8688` | music requests and slskd imports |
| Explo | `7288` | discovery and playlist workflow for user A |
| `explo-user-b` | `7289` | separate Explo state for user B |
| Aurral | `3001` | playlist acquisition and imports |
| MusicGrabber | `38274` | library and download helper |
| Soulbeet | `9765` | Soulseek acquisition workflow |
| Koito | `4110` | scrobble server for user A |
| `koito-user-b` | `4111` | scrobble server for user B |
| multi-scrobbler | `9078` | forwards Navidrome plays to ListenBrainz, Koito and Last.fm |
| octo-fiesta | `5274` | Subsonic playlist downloader |

slskd shares Gluetun's network namespace. Gluetun publishes the slskd API and web
ports and applies the forwarded Proton port. Lidarr uses the nightly LinuxServer
image because the Tubifarry plugin is part of the download workflow.

## data flow

```text
Lidarr / DroppedNeedle / Aurral
              │
              ▼
        slskd through Gluetun
              │
              ▼
      /mnt/data/slskd/complete
              │
              ▼
       /mnt/data/media/music
              │
              ▼
       Navidrome on jellyfin-ct
```

## storage

| path | contents |
|---|---|
| `/data/config/<service>` | per-service config and databases |
| `/mnt/data/slskd` | Soulseek incomplete and completed downloads |
| `/mnt/data/media/music` | shared music library |
| `/mnt/data/media/music/aurral` | Aurral playlist output |
| `/mnt/data/media/music/explo` | Explo user A library |
| `/mnt/data/media/music/explo-user-b` | Explo user B library |

Aurral reads the full `/data` tree and has write access to its playlist directory
and the completed slskd directory. Navidrome reads the same media dataset from
`/mnt/media/music` on `jellyfin-ct`.

## required variables

| component | variables |
|---|---|
| VPN | `PROTONVPN_WIREGUARD_PRIVATE_KEY`, `PROTONVPN_SERVER_COUNTRIES` |
| slskd | `SLSKD_UI_USERNAME`, `SLSKD_UI_PASSWORD`, `SLSKD_API_KEY`, `SOULSEEK_USERNAME`, `SOULSEEK_PASSWORD` |
| Explo | `EXPLO_UI_USERNAME`, `EXPLO_UI_PASSWORD` |
| Navidrome | `SUBSONIC_ADMIN_USERNAME`, `SUBSONIC_ADMIN_PASSWORD` |
| Soulbeet | `SOULBEET_SECRET_KEY` |
| Koito | `KOITO_SUBSONIC_PARAMS`, `KOITO_USER_B_SUBSONIC_PARAMS`, `KOITO_USER_A_API_KEY`, `KOITO_USER_B_API_KEY` |
| scrobbling | `LISTENBRAINZ_USER_A_TOKEN`, `LISTENBRAINZ_USER_B_TOKEN`, `LASTFM_USER_A_API_KEY`, `LASTFM_USER_A_SECRET` |
| octo-fiesta | `OCTO_FIESTA_MUSIC_SERVICE`, `OCTO_FIESTA_STORAGE_MODE`, `OCTO_FIESTA_DOWNLOAD_MODE` |
| optional sources | `DEEZER_ARL`, `QOBUZ_USER_AUTH_TOKEN`, `QOBUZ_USER_ID`, `SQUIDWTF_SOURCE`, `YANDEX_OAUTH_TOKEN` |

`multi-scrobbler-config.json` maps the user A and user B instances to the
ListenBrainz, Koito and Last.fm variables.

## first deploy

1. confirm Gluetun connects and receives a forwarded port.
2. confirm slskd uses that port and can reach Soulseek.
3. configure Lidarr's root folder under `/data/media/music` and connect the
   Tubifarry/slskd workflow.
4. configure DroppedNeedle with `/music` as its library,
   `http://gluetun:5030` as slskd, and `/slskd-downloads` as the completed path.
5. configure Navidrome scrobbling and verify multi-scrobbler receives events on
   port `9078`.
