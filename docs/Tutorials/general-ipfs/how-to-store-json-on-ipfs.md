---
title: "How to Store JSON on IPFS"
slug: "how-to-store-json-on-ipfs"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 18:36:28 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Fri Sep 15 2023 18:36:28 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/8cd8526-image.png)

Whether you’re building web3 applications or traditional applications, JSON is a fundamental building block. But what is JSON and where does it get stored? Let’s explore these questions as broadly as possible, but we’ll also narrow in on how JSON is especially applicable to web3 development.

## What is JSON

JSON stands for [JavaScript Object Notation](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON). It is a data format that is especially compatible with the JavaScript programming language (which is native to web browsers), but it is also used in many other programming languages because it has become so ubiquitous.

JSON is a text-based data format stored as a string. It can contain flat-structured date or nested data. An example of a flat JSON structure might be:

```json
{
  "appName": "JSON City",
  "version": "0.1",
  "author":"Justin Hunter",
}
```

And a nested version might look something like this:

```json
{
  "appName": "JSON City",
  "version": "0.1",
  "author":"Justin Hunter",
  "features": [
  {
    "name": "Uploads",
    "limit": 500,
    "fileTypeLimits": {
      "Text": 10,
      "Image": 100,
      "Video": 25
    }
  },
  ]
}
```

As you can see from the examples above, JSON can present a virtually endless amount of data and in many different formats. This makes it incredibly flexible and powerful. It’s why so many APIs respond in JSON. It’s why so many app structures rely on it.

It’s also why web3, specifically NFTs and DeFi, have leaned so heavily into the world of JSON.

## Why Does Web3 Use JSON?

If you came into the web3 world during the NFT boom, you may have been introduced to JSON for the first time even if you weren’t building anything. Every NFT had a record on the blockchain that pointed to a JSON file. That JSON file was like an API response in traditional applications. It told anyone looking at it everything they needed to know:

- What’s the name of this NFT?
- What’s the description?
- What attributes does it have?
- What media is associated with it?
- Etc

This JSON data did not live on-chain. It would be too expensive. But because NFTs are open, and blockchains are open, it’s important for the JSON and media to be open as well. This is why the vast majority of NFTs have JSON stored on IPFS.

```json
{
  "image": "ipfs://QmTzC9euDWL7mUGTskDq7KvatvEG65iwjwENSzkezuiF",
  "attributes": [
    {
      "trait type": "Background",
      "value": "MI Aquamarine"
    },
    {
      "trait type": "Fur",
      "value": "MI Pink"
    },
    {
      "trait type": "Eyes",
      "value": "M1 Closed"
    },
    {
      "trait type": "Clothes",
      "value": "Ml Leather Jacket"
    },
    {
      "trait type": "Hat",
      "value": "MI Irish Boho"
    },
    {
      "trait type": "Mouth",
      "value": "MI Phoneme L"
    }
  ]
}
```

We’ll dig into how to store JSON on IPFS, but we should also explore the world of DeFi and its ties to JSON.

DeFi tokens act very much like NFTs when it comes to data. The token itself lives on the blockchain. However, the token often has additional metadata associated with it. That data is in JSON form, and, by and large, it’s stored on IPFS. Protocols and apps building in the DeFi space also have orderbook data that they tend to need in an open format. So, guess what they do? They store this in JSON format and put it on IPFS.

```json
{
  "borrower": "Oxdef789..",
  "asset": "DAI",
  "amount": 75.0,
  "collateral": "ETH",
  "collateralAmount": 3.0,
  "duration": 15
}
```

## How To Store JSON on IPFS

The first step to storing JSON on IPFS is to create the data that needs to be stored. If you’re an app developer, this is likely a natural byproduct of building your app and planning user data interactions. For example, a user registration form might have a name field, an organization field, and a how did you hear about us field. You would very likely represent those fields and the responses as JSON and then store that JSON somewhere.

Adding that JSON to the IPFS network is simple if you know what you’re doing. If you run your own IPFS node, you would make a network request to communicate with that node and tell it to pin the JSON to your node. This would then make the JSON available on the public IPFS network. However, running your own IPFS node is not always an option, and even if it is, you may wish to have redundancies for your data. [That’s where a pinning service](https://www.pinata.cloud/blog/what-is-pinning) like [Pinata](https://pinata.cloud/) can save you a ton of time.

If you’re not a developer, Pinata has a simple interface that allows you to upload content (like JSON!). [Check out our guide](https://www.pinata.cloud/blog/how-to-pin-a-file-to-ipfs) on pinning a file to IPFS with Pinata here.

As a developer, though, you would likely be using the Pinata API to upload your content to the IPFS network through Pinata. Fortunately, we make this incredibly easy. [Once you’ve created an API key](https://www.youtube.com/watch?v=l4vPAeBtdms), you should have no issue uploading. [Here is a guide for uploading to Pinata](https://medium.com/pinata/a-beginners-guide-to-getting-started-with-the-pinata-node-js-sdk-7430def4e7df) through the API. Another benefit of using Pinata would be our SDK which makes uploading JSON a breeze. 

```jsx
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK({ pinataJWTKey: 'yourPinataJWTKey'});

const json = {
  borrower: "Oxdef789..",
  asset: "DAI",
  amount: 75.0,
  collateral: "ETH",
  collateralAmount: 3.0,
  duration: 15
}

const res = await pinata.pinJSONToIPFS(json)
```

## Your JSON is on IPFS, Now What?

Once you’ve stored your JSON on IPFS, you will likely want to use that file for your application, NFT, DeFi project, or something else. Fortunately, the IPFS network is essentially a global CDN, making it easy to retrieve content if you know the [content identifier (CID)](https://www.pinata.cloud/blog/what-is-an-ipfs-cid). Pinata makes this even faster and more reliable [with Dedicated IPFS Gateways](https://www.pinata.cloud/blog/what-is-an-ipfs-gateway).

With a gateway and your CID, you can retrieve your JSON and use it anytime you want. The power of a global and open network is in the available and portability of data. IPFS powers that and Pinata makes it easy.

Happy pinning!
