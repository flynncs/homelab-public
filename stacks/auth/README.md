# auth

OIDC, LDAP and forward-auth services on `auth-vm-1`.

## services

| service | ports | role |
|---|---|---|
| LLDAP | LDAP `3890`, web `17170` | directory for LDAP-backed services |
| pocket-id | `3055` | passkey authentication and OIDC provider |
| TinyAuth | `3001` | forward-auth endpoint backed by LLDAP |

pocket-id and LLDAP maintain separate identity stores. TinyAuth binds to LLDAP at
`ldap://lldap:3890`. all three containers share the `authnet` network.

## storage

| host path | service data |
|---|---|
| `/data/config/lldap` | directory database and keys |
| `/data/config/pocketid` | pocket-id database and OIDC clients |
| `/data/config/tinyauth` | TinyAuth data |

## required variables

- `LDAP_BASE_DN`
- `LDAP_BIND_DN`
- `LLDAP_ADMIN_PASS`
- `LLDAP_JWT_SECRET`
- `POCKETID_APP_URL`
- `POCKETID_ENCRYPTION_KEY`
- `TINYAUTH_APP_URL`

## first deploy

1. create users and groups in LLDAP.
2. register OIDC clients in pocket-id for applications using OIDC.
3. configure Caddy forward-auth routes against TinyAuth for applications without
   native OIDC support.
