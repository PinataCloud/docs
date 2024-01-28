---
title: "How Do I Upload Files to IPFS?"
slug: "how-do-i-upload-files-to-ipfs"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 18:35:03 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Mon Sep 18 2023 19:28:55 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/7761edd-image.png)

Usually when you think of uploading files your mind will go to a service like Dropbox, Google Drive, or maybe even S3. However, if you are working in Web3, you might think of [IPFS](https://www.pinata.cloud/blog/what-is-ipfs) for a lot of good reasons. It pairs perfectly with blockchain technology, filling the gaps of expensive on chain storage while keeping an immutable state and verification through the CID ([learn more about that here](https://www.pinata.cloud/blog/what-is-an-ipfs-cid)). But how do you get started? What’s the easiest way to upload files to IPFS? In this post we’ll show you a few ways and weigh out their advantages. 

## Using a Local IPFS Node

One way you can access IPFS is with a local IPFS node using an application like IPFS Desktop. Typically you would want to use this for personal use, not developing decentralized applications. This is an app you can run on your computer for Windows or Mac, and is relatively simple to use. All you have to do is visit their [downloads page](https://docs.ipfs.tech/install/ipfs-desktop/), install it, fire it up, then add some files. 

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmVRjzVyWYdKYwxcsDACv6zEq16achgo7L9savackWWuXL?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


Once you add some files you can see the CID for each file and access through a public gateway like `https://ipfs.io/ipfs/{CID}`. There are some disadvantages to this method though. One of them is that you have to keep the local node running 24/7 for files to be available, which means you have to keep your computer running too. Not ideal if you need consistent availability. The app can also tend to be slow and a bit clunky. 

## Cloud IPFS Nodes

If you’re a developer that is trying to build apps and you need consistent availability, you could look into running IPFS nodes in the cloud. This could take the form of a server running [IPFS Kubo](https://docs.ipfs.tech/how-to/command-line-quick-start/), a client written in Go. With this option you would have the advantage of completely customization. However setting this up would be much more difficult, as you would need to have quite a bit of cloud infrastructure experience and you would have to build an API to interact with it to upload files. Not only that, but IPFS infrastructure can be incredibly challenging to scale properly (not to mention possible abuse you may encounter). This is why most developers go with the next option. 

## IPFS Pinning Services

An [IPFS Pinning Service](https://www.pinata.cloud/blog/what-is-an-ipfs-pinning-service) like [Pinata](https://pinata.cloud) can help both developer and non-technical people alike as it makes IPFS just work. We’ve been scaling IPFS infrastructure for years so you don’t have to, keeping your IPFS content available, stable, and secure. To upload a file to Pinata,  just create a free account, click the “add files” button in the top right, choose your file, then upload. That easy! 

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmZcbvuwtTuYBrPb93is6n1ugSogPLeDSPjPsvBvNkvVa9?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


If you’re a developer Pinata offers a easy and accessible REST API, SDK, and even a Next.js template to help you hit the ground running with developing on IPFS. Uploading a file to IPFS using the Pinata SDK just takes a few lines of code. 

```jsx
const fs = require('fs');
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK({ pinataJWTKey: 'yourPinataJWTKey'});

const stream = fs.createReadStream('./yourfile.png');
const res = await pinata.pinFileToIPFS(stream)
```

Uploading to IPFS is really just the tip of the iceberg of what you can get with Pinata. Developers and individuals alike can enjoy also our [Dedicated Gateways](https://www.pinata.cloud/blog/what-is-an-ipfs-gateway) revolutionized the way people retrieve content from the IPFS network at blazing speeds and a built in CDN (which are [now included on our free plan](https://www.pinata.cloud/blog/pinatas-new-free-plan) 👀). So what are you waiting for? Go ahead and [sign up](https://app.pinata/cloud) and try uploading a file to IPFS today! 

Happy pinning!
