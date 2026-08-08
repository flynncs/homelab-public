# edge

newt connector between the local network and a Pangolin endpoint.

newt makes an outbound connection, so the stack publishes no ports and stores no
local state.

## required variables

- `PANGOLIN_ENDPOINT`
- `NEWT_ID`
- `NEWT_SECRET`

create the site and newt credentials in Pangolin, add them to `.env`, then deploy
the stack on `edge-ct`.
