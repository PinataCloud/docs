---
title: "Pin JSON"
slug: "post_pinning-pinjsontoipfs"
excerpt: "Uploads a JSON object to Pinata and pins it to IPFS"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 07 2023 19:48:25 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Thu Sep 21 2023 00:49:07 GMT+0000 (Coordinated Universal Time)"
---
This endpoint allows the sender to add and pin any JSON object they wish to Pinata's IPFS nodes. This endpoint is specifically optimized to only handle JSON content. Once the server receives the JSON, it is converted into a JSON file and pinned to our IPFS storage nodes. 

## Uploading and Pinning JSON

Each upload can optionally include additional information beyond just the file. Both `pinataOptions` and `pinataMetadata` can be included in the request. Their formats are document [here](ref:pinningpinfiletoipfs)
