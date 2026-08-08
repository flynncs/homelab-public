# syncthing

file synchronisation service on `mgmt-vm`.

| port | purpose |
|---:|---|
| `8384/tcp` | web UI |
| `22000/tcp` | sync protocol |
| `22000/udp` | QUIC sync protocol |
| `21027/udp` | local discovery |

## storage

| host path | container path | contents |
|---|---|---|
| `/data/config/syncthing` | `/config` | device identity and folder configuration |
| `/mnt/data` | `/data` | synchronised datasets |

add remote devices through the web UI, then define each shared folder under
`/data`. the device identity under `/config` must be included in backups.
