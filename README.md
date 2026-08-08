# homelab

Proxmox guests in OpenTofu, host configuration in Ansible, and Compose stacks
managed by Komodo.

## topology

| guest | type | role |
|---|---|---|
| `mgmt-vm` | VM | Komodo Core, management and Syncthing |
| `apps-vm-1` | VM | arr, downloaders, music and BookOrbit |
| `auth-vm-1` | VM | pocket-id, lldap and tinyauth |
| `jellyfin-ct` | LXC | Jellyfin and Navidrome with iGPU passthrough |
| `immich-ct` | LXC | Immich with iGPU passthrough |
| `edge-ct` | LXC | newt tunnel client |
| `apps-ct` | LXC | BentoPDF, Tandoor and Norish |
| `adguard-ct` | LXC | Pi-hole DNS |
| `rp-ct` | LXC | Caddy reverse proxy |

the guest network is `10.20.0.0/24`. ids and addresses are listed in
[infra/README.md](infra/README.md).

## configuration

| layer | contents |
|---|---|
| `infra/` | complete OpenTofu guest topology and Proxmox modules |
| `ansible/` | inventory, baseline, Docker, updates, storage and Komodo roles |
| `stacks/` | active Compose stacks and Komodo resource definitions |
| `komodo/` | ResourceSync configuration for the stack catalogue |
| `services/` | route registry used to generate Caddy and network rules |
| `scripts/` | route generator and consistency checks |
| `docs/` | architecture, generated routes and runbook |
| `examples/` | standalone module examples |

## stack catalogue

| group | services |
|---|---|
| media | Jellyfin, Immich, Navidrome |
| arr | Sonarr, Radarr, Prowlarr, Byparr, Profilarr, Maintainerr, Cleanuparr, Seerr |
| downloads | SABnzbd, qBittorrent, Gluetun |
| music | Lidarr, slskd, DroppedNeedle, Explo, Aurral, MusicGrabber, Soulbeet, Koito, multi-scrobbler, octo-fiesta |
| identity | pocket-id, lldap, tinyauth |
| applications | BentoPDF, Tandoor, Norish, BookOrbit |
| infrastructure | Komodo, Caddy, Pi-hole, newt, Syncthing |

full Compose configuration is under [stacks/](stacks/).

## opentofu

```bash
cd infra
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
```

the API token limitation for LXC bind mounts and device configuration is covered
in [infra/README.md](infra/README.md#api-token-limitation).

## ansible

```bash
cd ansible
ansible-galaxy install -r requirements.yaml
cp group_vars/all/vault.example.yaml group_vars/all/vault.yaml
ansible-playbook site.yaml
```

## route generation

```bash
npm ci
npm run gen:routes
npm run check:routes
```

the generator reads the service registry and Ansible inventory, then writes the
Caddyfile, route table and example Proxmox forwarding rules.

## checks

```bash
tofu fmt -check -recursive
tofu -chdir=infra validate
npm run check:routes
```
