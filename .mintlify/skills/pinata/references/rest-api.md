# Pinata REST API reference

Two hosts, one key. Every request sends `Authorization: Bearer $PINATA_JWT`.

- `https://uploads.pinata.cloud/v3`: uploads, presigned upload URLs, upload limits
- `https://api.pinata.cloud/v3`: files, groups, gateways, links, pin by CID, signatures

Answers wrap their payload in `{ "data": … }`. Lists page with `limit` and `pageToken` (the `next_page_token` of the previous page). `{network}` is `public` or `private`. Full reference: https://docs.pinata.cloud/api-reference

```bash
curl -s https://api.pinata.cloud/data/testAuthentication -H "Authorization: Bearer $PINATA_JWT"
```

## Upload

`POST https://uploads.pinata.cloud/v3/files` with `multipart/form-data`:

| Field | Notes |
|---|---|
| `file` | The file. Repeat it for a folder, with each part's filename `<folder>/<path>` |
| `network` | `public` or `private`. **Defaults to `private`** |
| `name` | File or folder name |
| `group_id` | Group on the same network |
| `keyvalues` | A JSON object as a string, e.g. `{"env":"prod"}` (at most 9 pairs) |
| `cid_version` | `v1` (default), `v0` (`Qm…` CIDs) or `unixfs-v1-2025` |
| `car` | `true` to upload a CAR file as its DAG (public only) |

```bash
# One file
curl -s https://uploads.pinata.cloud/v3/files -H "Authorization: Bearer $PINATA_JWT" \
  -F "file=@./photo.jpg" -F "network=public" -F "name=photo.jpg"

# A folder, one CID (up to 150 files per request; use the SDK's folder() or TUS for more)
curl -s https://uploads.pinata.cloud/v3/files -H "Authorization: Bearer $PINATA_JWT" \
  -F "file=@site/index.html;filename=site/index.html" \
  -F "file=@site/css/app.css;filename=site/css/app.css" \
  -F "name=site" -F "network=public"
```

Large files: use the SDK, or TUS resumable uploads to the same `/v3/files` endpoint.

`GET https://uploads.pinata.cloud/v3/files/limits` returns `{ "data": { "folder_max_files": 30000 } }`.

## Presigned upload URL

`POST https://uploads.pinata.cloud/v3/files/sign` (server side) with a JSON body:

```json
{
  "date": 1735689600,
  "expires": 60,
  "network": "public",
  "filename": "avatar.png",
  "max_file_size": 5000000,
  "allow_mime_types": ["image/*"],
  "group_id": "…",
  "keyvalues": { "user": "123" }
}
```

`date` is the current Unix time in seconds, and `expires` is how many seconds after it the URL stays valid. The answer is `{ "data": "<signed URL>" }`. The client POSTs the same multipart form to that URL without any `Authorization` header. For folders, include `"directory"` in `allow_mime_types` whenever you restrict MIME types.

## Files

| Method and path | Purpose |
|---|---|
| `GET /files/{network}` | List or search. Query: `name`, `cid`, `mimeType`, `group` (`null` for files in no group), `keyvalues[key]=value`, `order` (`ASC`/`DESC`), `cidPending`, `limit`, `pageToken` |
| `GET /files/{network}/{id}` | One file |
| `PUT /files/{network}/{id}` | Update `name`, `keyvalues` (replaces them) or `expires_at` |
| `DELETE /files/{network}/{id}` | Delete |

```bash
curl -s "https://api.pinata.cloud/v3/files/private?keyvalues%5Benv%5D=prod&limit=10" \
  -H "Authorization: Bearer $PINATA_JWT"
```

A `404` for an id usually means the wrong network.

## Links and gateways

Public file: `https://<gateway>/ipfs/<cid>`, with no API call.

Private file, signed and expiring: `POST /files/private/download_link`

```json
{ "url": "https://example.mypinata.cloud/files/<cid>", "expires": 600, "date": 1735689600, "method": "GET" }
```

The answer is `{ "data": "<signed URL>" }`. Signed `/files/` links also work on gateways with access controls.

`GET /gateways` lists the account's gateways (`domain` is the subdomain: `<domain>.mypinata.cloud`), with `restrict` and `custom_domains`. `GET /gateways/{id}` includes the gateway's access-control settings.

## Groups

| Method and path | Purpose |
|---|---|
| `GET /groups/{network}` | List (`name`, `limit`, `pageToken`) |
| `POST /groups/{network}` | Create: `{ "name": "…" }` |
| `GET` / `PUT` / `DELETE /groups/{network}/{id}` | Get, rename (`{ "name" }`), delete (keeps its files) |
| `PUT` / `DELETE /groups/{network}/{id}/ids/{file_id}` | Add or remove a file |

## Pin by CID (public)

| Method and path | Purpose |
|---|---|
| `POST /files/public/pin_by_cid` | `{ "cid", "name", "group_id", "keyvalues", "host_nodes" }` queues a pin from the IPFS network |
| `GET /files/public/pin_by_cid` | Jobs. Filter by `status` (`prechecking`, `searching`, `retrieving`, `downloaded`, `backfilled`, `expired`, `cancelled`; repeatable), `cid`, `order` |
| `DELETE /files/public/pin_by_cid/{id}` | Cancel a job |

## Signatures (public CIDs)

`POST` / `GET` / `DELETE /files/public/signature/{cid}`, with POST body `{ "signature": "0x…", "address": "0x…" }` (EIP-712).

## Errors

`401`: bad or missing key. `403`: the key lacks a scope, or the account is over a limit. `404`: not found on that network. `429`: rate limited, so wait for `Retry-After`. Error bodies look like `{ "error": { "reason", "details" } }` or `{ "error": { "code", "message" } }`.
