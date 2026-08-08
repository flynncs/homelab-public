# architecture

## ownership

| layer | responsibility |
|---|---|
| OpenTofu | Proxmox VM and LXC lifecycle |
| Ansible | guest operating systems, Docker, updates and mounts |
| Komodo | Compose stack deployment and updates |
| Caddy | reverse proxy, TLS and upstream routing |
| Pi-hole | local DNS and split-horizon records |

Ansible installs Docker and Komodo periphery on each host. Komodo manages the
container state.

## guest layout

```text
Proxmox
├── mgmt-vm          Komodo Core, Syncthing
├── apps-vm-1        arr, downloads, music, BookOrbit
├── auth-vm-1        pocket-id, lldap, tinyauth
├── jellyfin-ct      Jellyfin, Navidrome, iGPU, media storage
├── immich-ct        Immich, iGPU, photo storage
├── edge-ct          newt tunnel client
├── apps-ct          BentoPDF, Tandoor, Norish
├── adguard-ct       Pi-hole
└── rp-ct            Caddy
```

the resource sizes are recorded in `infra/main.tf`. VMs are used for management,
identity and the larger application workload. LXCs are used for isolated service
roles and media workloads requiring direct host devices or storage.

## request paths

```text
local client
  └── Pi-hole
        └── Caddy
              └── service

remote client
  └── remote Pangolin host
        └── newt on edge-ct
              └── service
```

`services/routes.yaml` records public and internal names, upstream hosts and
ports. `scripts/gen-routes.js` resolves host roles through the Ansible inventory
and generates the Caddyfile and forwarding rules.

## storage

storage is under `/srv/storage` on the Proxmox host, mounted as `/mnt/data` or
service-specific paths inside guests. media and photo storage are separate LXC
mount points. application stacks share `/mnt/data` where atomic moves between
download and library directories are required.

## gpu passthrough

the Jellyfin and Immich LXCs receive the render and card devices through the LXC
module. device path, uid, gid and mode are explicit module inputs.

standard guest operations use a scoped Proxmox API token. arbitrary host bind
mounts use a separate `root@pam` host step because Proxmox rejects them under
token authentication.
