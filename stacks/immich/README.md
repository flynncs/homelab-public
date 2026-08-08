# immich

photo library, machine learning and database services on `immich-ct`.

## services

| service | role |
|---|---|
| `immich-server` | API, web application, uploads and background jobs |
| `immich-machine-learning` | face recognition and search models |
| `redis` | job queue through Valkey |
| `database` | PostgreSQL with VectorChord and pgvectors |

the web application is published on port `2283`. Redis, PostgreSQL and machine
learning remain inside the Compose network.

## storage

| variable or volume | container path | contents |
|---|---|---|
| `UPLOAD_LOCATION` | `/data` | uploaded photos and generated assets |
| `DB_DATA_LOCATION` | PostgreSQL data directory | database |
| `model-cache` | `/cache` | downloaded machine-learning models |

`UPLOAD_LOCATION` and `DB_DATA_LOCATION` should be separate directories. backups
need the upload tree and a consistent PostgreSQL dump.

## required variables

- `IMMICH_VERSION`
- `UPLOAD_LOCATION`
- `DB_DATA_LOCATION`
- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_DATABASE_NAME`

the LXC receives `/dev/dri` devices from OpenTofu. the Compose hardware
acceleration blocks are currently commented out, so transcoding and machine
learning use CPU until those sections and matching image tags are enabled.
