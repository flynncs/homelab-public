# komodo

ResourceSync configuration for every Compose stack under `stacks/`.

`resources.toml` points Komodo at each stack manifest. a sync reads the listed
`komodo.toml` files and creates or updates the stack definitions.

## manifest fields

| field | purpose |
|---|---|
| `name` | stack name in Komodo |
| `server` | target matching the Ansible inventory host |
| `repo` and `branch` | git source |
| `file_paths` | Compose files passed to Docker Compose |
| `run_directory` | directory containing Compose and environment files |
| `webhook_enabled` | enables deploy hooks for the stack |

## sync

1. add each inventory host to Komodo using the name from the stack's `server`
   field.
2. create a ResourceSync from `komodo/resources.toml`.
3. run the sync and review the resulting stacks.
4. make the variables from each stack's `.env.example` available to Compose
   before deployment.

when adding a stack, add its `komodo.toml` path to the `resource_path` array.
