# ansible

guest configuration for the topology in `infra/`.

## inventory

`inventories/generated/hosts.yaml` contains the same hosts and addresses
as the OpenTofu configuration.

| group | hosts | configuration |
|---|---|---|
| `baseline` | all guests | packages, DNS, SOPS and automatic updates |
| `docker_hosts` | application guests | Docker and Komodo periphery |
| `mgmt` | `mgmt-vm` | Komodo Core |
| `proxmox_hosts` | `homelab-pve` | automatic package maintenance only |

## roles

| role | purpose |
|---|---|
| `baseline` | guest agent, resolver, base packages and SOPS |
| `apt_maintenance` | unattended security updates and apt timers |
| `docker` | Docker Engine and Compose plugin |
| `komodo_core_compose` | Komodo Core with MongoDB |
| `nfs_mount` | shared storage mounts |

the external `bpbradley.komodo` role installs Komodo periphery.

## usage

```bash
cd ansible
ansible-galaxy install -r requirements.yaml
cp group_vars/all/vault.example.yaml group_vars/all/vault.yaml
ansible-playbook site.yaml
```

set every value in `vault.yaml` before running the playbooks. encrypt the file
with Ansible Vault if it needs to be stored outside the local checkout.

for SOPS, encrypt the template as `group_vars/all/vault.sops.yaml` instead. the
`community.sops.sops` vars plugin is already enabled in `ansible.cfg`.

`site.yaml` applies the baseline, Docker and Komodo playbooks in that order.
individual hosts can be selected with `--limit`.
