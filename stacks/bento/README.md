# bentopdf

single-container PDF toolset on `apps-ct`.

| service | image | host port |
|---|---|---:|
| `bentopdf` | `bentopdf/bentopdf:latest` | `3000` |

the stack has no database, environment variables or persistent volumes. Caddy
provides the internal route at `bentopdf.internal.home.example`.
