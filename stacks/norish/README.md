# norish

recipe manager with OIDC login and AI-assisted recipe import on `apps-ct`.

## services

| service | role |
|---|---|
| `app` | Norish web application on host port `8089` |
| `db` | PostgreSQL 17 database |
| `redis` | cache and job state |
| `chrome-headless` | browser used for page extraction |

the application uses pocket-id at `auth.home.example` for OIDC. password login
is disabled. Google AI Studio's OpenAI-compatible endpoint handles AI parsing
with the configured Gemini model.

## storage

| host path | contents |
|---|---|
| `/data/config/norish/uploads` | imported files and uploads |
| `/data/config/norish/postgres` | PostgreSQL data |
| `/data/config/norish/redis` | Redis data |

## required variables

- `NORISH_DB_PASSWORD`
- `NORISH_MASTER_KEY`
- `NORISH_AI_API_KEY`
- `NORISH_OIDC_CLIENT_ID`
- `NORISH_OIDC_CLIENT_SECRET`

## first deploy

```bash
sudo mkdir -p /data/config/norish/{postgres,redis,uploads}
sudo chown 1000:1000 /data/config/norish/uploads
```

register `https://recipes.home.example/api/auth/oauth2/callback/oidc` as the
pocket-id callback. the first OIDC account becomes the Norish owner.
