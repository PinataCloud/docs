---
title: "IPFS Gateways"
slug: "dedicated-gateways"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Jul 18 2023 11:21:02 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Sep 12 2023 17:18:41 GMT+0000 (Coordinated Universal Time)"
type: "link"
link_url: "https://docs.pinata.cloud/docs/ipfs-gateways"
---
## Why Gateways?

> 📘 Gateways are the portal to access content pinned on IPFS on modern-day applications.

### How content is retrieved from IPFS

When you pin your content to Pinata, it will be available to all on the public IPFS network. This means that anybody running an IPFS node can access content stored on Pinata through their own IPFS node.

However, directly running a node isn't the only way to access content, nor is it the easiest. The most common way to retrieve content on the IPFS network is through an **IPFS gateway.**

#### The barrier of modern-day applications

Most applications, including your everyday browser, do not yet support IPFS natively. **Gateways** are IPFS nodes allow you to leverage the HTTP protocol (via a web URL) to request data by CID from the IPFS network. 

Gateways often take the following form:

 `https://example.gateway.com/ipfs/<CID>`

The `CID` is the content identifier (also known as a hash) for the content you want to retrieve.

In some ways, gateways are sort of like a _translator_ that allow your content to be understood and served properly on modern platforms.

### Pinata's Gateway Services

Pinata provides two types of gateway services: the [Pinata Public Gateway](doc:pinata-public-gateway) and [Dedicated Gateways](doc:dedicated-gateways-1).

Further reading:

[The Power of Dedicated Gateways](https://www.pinata.cloud/blog/the-power-of-dedicated-gateways)
