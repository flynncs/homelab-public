# tandoor

recipe manager and PostgreSQL database on `apps-ct`.

## services

| service | role |
|---|---|
| `web_recipes` | Tandoor web application on host port `8088` |
| `db_recipes` | PostgreSQL 16 database |

the web application waits for the PostgreSQL health check before starting. OIDC
login uses Django allauth; the provider configuration is supplied through
`SOCIALACCOUNT_PROVIDERS`.

## storage

| path or volume | contents |
|---|---|
| `/data/config/tandoor/postgresql` | PostgreSQL data |
| `/data/config/tandoor/mediafiles` | uploaded recipe media |
| `tandoor-staticfiles` | generated static assets |

## required variables

- `POSTGRES_DB`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `SECRET_KEY`
- `ALLOWED_HOSTS`
- `CSRF_TRUSTED_ORIGINS`
- `SOCIALACCOUNT_PROVIDERS`

`ENABLE_SIGNUP` defaults to `0`. create the OIDC client before the first login
and set its callback URL to the Django allauth endpoint for the configured host.
