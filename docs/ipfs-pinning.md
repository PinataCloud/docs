---
title: "IPFS Pinning"
slug: "ipfs-pinning"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Jul 18 2023 11:17:23 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Sep 12 2023 21:03:50 GMT+0000 (Coordinated Universal Time)"
---
IPFS "Pinning" is the foundation to getting content on IPFS. When you upload a file to IPFS, the IPFS node will create a [CID](doc:cids) for that file which will act as the identifier and the address. Then it will "pin" that file to the IPFS network, making it available for other nodes to request it. At that point any other IPFS node can request the content for a CID, and the content will pass through other nodes leaving a cache on that node. This makes it faster to fetch files again if those nodes are used. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/829e908-homepage-new_fonts.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


As the cache on these nodes through, it will soon become bloated with too much data, similar to how your computer can get slow if it's loaded down with too many cache files. IPFS nodes have a way to handle this though, and that's through something called "Garbage Collection." This is a process where the IPFS node will dump any content in the cache that is not being pinned to IPFS. However if there is content in the cache that is still being pinned by at least one IPFS node, then it will stay. Pinning is what keeps content on IPFS, and as long as content is being pinned by one node, it will stay available on the network. 

## How Do I Pin Files to IPFS?

With Pinata there are a few ways you can pin files to IPFS

### API & SDKs

If you're a developer that needs to build decentralized applications then you will likely want to use the [Pinata API](ref:pinningpinfiletoipfs) or [Pinata SDK](doc:pinata-sdk). These make it simple to upload files or raw JSON to IPFS! 

```javascript pinFileToIPFS.js
const fs = require('fs');
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK({ pinataJWTKey: 'yourPinataJWTKey'});

const stream = fs.createReadStream('./yourfile.png');
const res = await pinata.pinFileToIPFS(stream)
```

> 📘 Check out the [Getting Started](doc:getting-started) guide to upload your first file through the API!

We also have other tools like the [Pinata CLI](doc:pinata-cli)  or [Next.js Starter](doc:nextjs-starter) which can be used to upload using [API Keys](doc:api-keys).

### Web App

If you're non-technical you can use [Pinata App](doc:files-page) to upload files, perfect if you just want to get started with NFTs and IPFS! It's as simple as clicking the "Add Files" button in the top right corner of the [files page](doc:files-page), selecting your file, give it a name, then upload. Once its complete you'll see it listed in the files page! 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/24fd110-app-upload.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


> 📘 Start uploading by [signing up for a free account](https://app.pinata.cloud/register)!

### Pin by CID

Another way you can upload content to Pinata is by transferring content that is already on IPFS. This could be CIDs that are on your own local IPFS node or another IPFS pinning service! You can do this with the "Add Files" button in the web app like so:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f8d12b2-pin-by-cid.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Or you can pin by CID with our API using the [Pin By CID](ref:post_pinning-pinbyhash) endpoint with a code snippet like this:

```javascript pinByCID.js
const axios = require('axios');

const data = JSON.stringify({
  hashToPin: 'bafkreih5aznjvttude6c3wbvqeebb6rlx5wkbzyppv7garjiubll2ceym4'
})

const res = await axios.post('https://api.pinata.cloud/pinning/pinByHash', {
	headers: {
    accept: 'application/json', 
    'content-type': 'application/json',
    'Authorization': 'Bearer YOUR_JWT'
  },
  body: data
})

console.log(res.data)
```
