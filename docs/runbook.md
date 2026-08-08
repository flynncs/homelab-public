# runbook

## initial setup

1. set the addresses and domains for the network.
2. copy `infra/terraform.tfvars.example` to `infra/terraform.tfvars` and set the
   Proxmox token and initial guest password.
3. copy `ansible/group_vars/all/vault.example.yaml` to
   `ansible/group_vars/all/vault.yaml` and set every value.
4. copy the required stack `.env.example` files to `.env` and set their values.
5. set the Komodo git account and repository.

`vault.yaml`, `terraform.tfvars` and stack `.env` files are ignored. use
`vault.sops.yaml` when the Ansible values need to be stored in git.

## provision guests

```bash
cd infra
tofu init
tofu plan
tofu apply
```

review all mount-point and device changes separately. Proxmox may require
`root@pam` for the host-path portion of LXC configuration.

## configure guests

```bash
cd ansible
ansible-galaxy install -r requirements.yaml
ansible-playbook site.yaml
```

limit the first run to one host if the inventory or SSH configuration has not
been tested:

```bash
ansible-playbook site.yaml --limit apps-ct
```

## import stacks

1. add the inventory hosts to Komodo with names matching the `server` field in
   each `komodo.toml`.
2. import `komodo/resources.toml` as a ResourceSync.
3. sync resources.
4. review each stack's environment file and volume paths.
5. deploy one stack at a time.

## add a guest

1. add the guest identity to `infra/main.tf`.
2. add the VM or LXC module block.
3. add the same hostname and address to the Ansible inventory.
4. add it to the required inventory groups.
5. run `tofu plan`, then limit Ansible to the new host.

## add a stack

1. create `stacks/<name>/compose.yaml`.
2. add `.env.example` with variable names and non-secret defaults.
3. create `stacks/<name>/komodo.toml` with the target server and compose path.
4. add the manifest path to `komodo/resources.toml`.
5. add routes to `services/routes.yaml` if required.
6. run the checks below before pushing.

## add or change a route

edit `services/routes.yaml`; do not edit the generated Caddyfile directly.

```bash
npm ci
npm run gen:routes
npm run check:routes
```

review all services marked `external: true` before applying the generated
configuration.

## validation

```bash
tofu fmt -check -recursive
tofu -chdir=infra validate
npm run check:routes

for file in $(find stacks -name compose.yaml | sort); do
  docker compose -f "$file" config --no-interpolate --quiet
done
```
