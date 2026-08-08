# bookorbit

book library application and PostgreSQL database on `apps-vm-1`.

## services

| service | image | role |
|---|---|---|
| `app` | `ghcr.io/bookorbit/bookorbit:latest` | web application and library scanner |
| `postgres` | `pgvector/pgvector:pg18` | application database with vector support |

the app is published on port `3000`, runs with a read-only root filesystem, and
uses a tmpfs for `/tmp`. the database is available only inside the Compose
network.

## storage

| host path | container path | contents |
|---|---|---|
| `/mnt/data/media/books` | `/books` | book library |
| `/data/config/bookorbit/app` | `/data` | application state |
| `/data/config/bookorbit/postgres` | PostgreSQL data directory | database |

## required variables

- `POSTGRES_PASSWORD`
- `JWT_SECRET`
- `SETUP_BOOTSTRAP_TOKEN`
- `APP_IMAGE` when overriding the default image

use the bootstrap token for initial setup, then remove or rotate it.
