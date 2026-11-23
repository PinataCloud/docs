# `pinata` SDK reference

`npm i pinata` (v2). TypeScript, works in Node 20+, browsers, Bun, Deno and edge runtimes. Docs: https://docs.pinata.cloud/sdk

```ts
import { PinataSDK } from "pinata";

const pinata = new PinataSDK({
  pinataJwt: process.env.PINATA_JWT,          // server only
  pinataGateway: "example.mypinata.cloud",    // host, no https://
  pinataGatewayKey: process.env.PINATA_GATEWAY_KEY, // optional: gateway with access controls
});
```

Most namespaces have a `public` and a `private` side: `pinata.upload.public`, `pinata.files.private`, `pinata.groups.public`, …

## Uploads: `pinata.upload.public` / `pinata.upload.private`

Each method returns a builder; `await` it to send. Builder options can be chained:

| Builder option | Effect |
|---|---|
| `.name(name)` | File name |
| `.keyvalues({ k: "v" })` | Metadata (at most 9 pairs) |
| `.group(groupId)` | Add to a group on the same network |
| `.cidVersion("v0" \| "v1")` | CID version (default `v1`) |
| `.url(signedUrl)` | Upload through a presigned URL (no JWT needed) |
| `.key(jwt)` | Use another JWT for this upload |
| `.vectorize()` | Vectorize for semantic search (file must be in a group) |
| `.waitForCid(false)` | Uploads over 90 MiB: return once the bytes are stored, before the CID is registered |

Options with no builder method go in the second argument: `file(f, { expires_at })` sets the time (Unix seconds, in the future) when the file is deleted. There is no `.expires()` method.

| Method | Uploads |
|---|---|
| `file(file)` | One `File`. Over 90 MiB it switches to resumable uploads automatically |
| `json(object)` | An object as a `.json` file |
| `base64(string)` | Base64 content |
| `url(url)` | Fetches the URL from where the SDK runs, then uploads it |
| `fileArray(files)` | Several files as one folder in a single request (small folders) |
| `folder(files, { concurrency, retries, onProgress, folderId })` | A folder file by file with retries and progress. Paths come from `webkitRelativePath` or `{ path, file }` entries. Use it for anything beyond a few files |
| `cid(cid)` (public only) | Pin an existing CID from IPFS; follow it with `pinata.files.public.queue()` |
| `createSignedURL({ expires, maxFileSize, mimeTypes, name, groupId, keyvalues, forDirectory })` | Presigned upload URL, created server-side |

`pinata.upload.limits()` returns `{ folder_max_files }`.

The upload response: `{ id, name, cid, size, number_of_files, mime_type, group_id, keyvalues, network, created_at }`.

## Files: `pinata.files.public` / `pinata.files.private`

```ts
const page = await pinata.files.public
  .list()
  .name("logo")              // also: .cid(), .mimeType(), .group(id), .noGroup(true),
  .keyvalues({ app: "web" }) //       .order("ASC"|"DESC"), .limit(n), .pageToken(t), .cidPending(true)
  .limit(50);
// page.files, page.next_page_token

for await (const item of pinata.files.public.list().group(groupId)) { /* every page */ }

await pinata.files.public.get(id);
await pinata.files.public.update({ id, name, keyvalues, expires_at });
await pinata.files.public.delete([id1, id2]);
```

Swaps (paid plans) serve new content at an old CID on your gateways: `addSwap({ cid, swapCid })`, `getSwapHistory({ cid, domain })`, `deleteSwap(cid)`.

Pin-by-CID jobs: `pinata.files.public.queue()` lists them (filter with `.cid()` and `.status()`), and `deletePinRequest(id)` cancels one.

## Gateways

```ts
await pinata.gateways.public.convert(cid);           // "https://<gateway>/ipfs/<cid>"
await pinata.gateways.public.get(cid);               // { data, contentType }
await pinata.gateways.private.createAccessLink({ cid, expires: 3600 }); // signed URL
await pinata.gateways.private.get(cid);              // fetches through a 30 s access link
```

Image resizing chains after `get` or `createAccessLink`, for example `pinata.gateways.private.createAccessLink({ cid, expires: 600 }).optimizeImage({ width: 400, format: "webp" })`. The options are `width`, `height`, `dpr`, `fit`, `gravity`, `quality`, `format` (`"auto"` or `"webp"`), `animation`, `sharpen`, `onError` and `metadata`.

## Groups: `pinata.groups.public` / `pinata.groups.private`

```ts
const group = await pinata.groups.public.create({ name: "Avatars" });
await pinata.groups.public.list().name("Ava").limit(10);
await pinata.groups.public.get({ groupId });
await pinata.groups.public.update({ groupId, name: "Profile pictures" });
await pinata.groups.public.addFiles({ groupId, files: [fileId] });
await pinata.groups.public.removeFiles({ groupId, files: [fileId] });
await pinata.groups.public.delete({ groupId }); // files are kept
```

## Other namespaces

- `pinata.signatures.public.add({ cid, signature, address })` / `get(cid)` / `delete(cid)`: EIP-712 signatures, for public CIDs.
- `pinata.keys.create({ keyName, permissions, maxUses })`, `keys.list()`, `keys.revoke([key])`: API keys. Prefer scoped keys with `maxUses` for anything handed to another system.
- `pinata.x402.*`: payment instructions for paid content (USDC on Base).
- `pinata.analytics.*`: gateway request and bandwidth analytics.

## Errors

The SDK throws `AuthenticationError` (401/403), `NetworkError` (other HTTP errors, with `statusCode` and `details`), `ValidationError` (bad input or missing config) and `PinataError`. Retry `NetworkError` with status 429 or 5xx after a pause.
