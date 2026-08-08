# infrastructure

OpenTofu configuration for the Proxmox topology.

## guests

| guest | type | id | address | role |
|---|---|---:|---|---|
| `mgmt-vm` | VM | 200 | `10.20.0.50` | Komodo Core and management |
| `apps-vm-1` | VM | 201 | `10.20.0.51` | media automation and music |
| `auth-vm-1` | VM | 202 | `10.20.0.53` | pocket-id, lldap and tinyauth |
| `jellyfin-ct` | LXC | 203 | `10.20.0.40` | Jellyfin, Navidrome and iGPU |
| `immich-ct` | LXC | 204 | `10.20.0.41` | Immich and iGPU |
| `edge-ct` | LXC | 205 | `10.20.0.42` | Pangolin tunnel client |
| `apps-ct` | LXC | 206 | `10.20.0.43` | application stacks |
| `adguard-ct` | LXC | 207 | `10.20.0.44` | Pi-hole DNS |
| `rp-ct` | LXC | 208 | `10.20.0.45` | Caddy reverse proxy |

## usage

```bash
cd infra
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
```

`terraform.tfvars` is ignored. set the API endpoint, token, guest password,
template, datastore and SSH key path before applying.

## api token limitation

the provider uses a Proxmox API token for standard guest lifecycle operations.
Proxmox rejects arbitrary host bind mounts unless the request is authenticated
as `root@pam`. apply those fields through a root-authenticated host step and keep
them ignored by the token-authenticated OpenTofu lifecycle.

GPU device entries may also require host-side ownership and group changes. the
module exposes `path`, `uid`, `gid` and `mode` so the final LXC device mapping is
recorded in code.
