---
title: "How Can I Get My IPFS CID?"
slug: "how-can-i-get-my-ipfs-cid"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 18:23:03 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Mon Sep 18 2023 19:29:12 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/0b90022-image.png)

One of the most crucial things in Web3 is the CID; it acts as both [the identifier and the address for content stored on IPFS](https://www.pinata.cloud/blog/what-is-an-ipfs-cid). It’s used all over the place from NFTs to [DeFi](https://www.pinata.cloud/blog/why-you-should-consider-ipfs-for-your-defi-projects), tying together blockchain and off-chain storage to build a decentralized ecosystem. If you’re looking to get a CID for your own content, you first have to pin it to IPFS, which you can read in more detail [here](https://www.pinata.cloud/blog/how-do-i-upload-files-to-ipfs). In this post we’ll show you two ways you can easily get your IPFS CID. 

## The Pinata App

A simple and easy way to get a CID for your content is to use the Pinata App. This portal is made to be less technical and intuitive, making it seamless for anyone who wants to put a file on IPFS. To get started, first signup at [app.pinata.cloud](http://app.pinata.cloud) for a free account which will give you 1GB and 500 files worth of storage. After signing up, simply click on the “Add Files” button in the top right. From there pick your file, give it a name, and click upload; that easy! 

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/Qmer2ReDzussRC2CZCZRK4TPp3jxT191bz4WwfwwsVX7FD?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


Once the file has been uploaded, you’ll see the CID listed next to the name. Go ahead and click on it to copy the CID to your clipboard, and you’re ready to share your file across the blockchain 😎

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmQjkEtcgBPxrQZmLV28553XmA8aEjo4rgHNuSB37Wv2XB?filename=video.mp4\" type=\"video/mp4\">\n</video>\n"
}
[/block]


## The Pinata API

If you’re a developer and need to work with IPFS on a larger scale and more programmatically, then you’ll want to use the Pinata API. It’s an easy to use REST API with some great [documentation you can check out](https://docs.pinata.cloud/reference/post_pinning-pinfiletoipfs), and uploading a file to get the CID will be a piece of cake. First you’ll want to go ahead and [signup](https://app.pinata.cloud) for a free account and create an API key. You can either give it admin permissions or just select the pinFileToIPFS if you want [scoped permissions](https://www.pinata.cloud/blog/how-to-use-scoped-api-keys-with-ipfs-app-development). Be sure to save the JWT which we’ll use as our authorization. 

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmajGsjxGgD8iebBEF5QAVfYZextZV4niNgzSUt3WkPMzS?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


Now make a new project directory with your terminal and install some dependencies 

```bash
mkdir pinata-upload && cd pinata-upload && npm install axios fs form-data
```

Next you can create a basic Node.js file with `touch index.js` and write the following code.

```jsx
const axios = require('axios')
const FormData = require('form-data')
const fs = require('fs')
const JWT = 'PASTE_YOUR_PINATA_JWT'

const pinFileToIPFS = async () => {
    const formData = new FormData();
    const src = "path/to/file.png";
    
    const file = fs.createReadStream(src)
    formData.append('file', file)
    
    const pinataMetadata = JSON.stringify({
      name: 'API File',
    });
    formData.append('pinataMetadata', pinataMetadata);

    try{
      const res = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS", formData, {
        maxBodyLength: "Infinity",
        headers: {
          'Content-Type': `multipart/form-data; boundary=${formData._boundary}`,
          'Authorization': `Bearer ${JWT}`
        }
      });
      console.log(res.data);
    } catch (error) {
      console.log(error);
    }
}

pinFileToIPFS()
```

Be sure to update the JWT constant at the top with your own API key (and of course use something like `dotenv` when putting anything in production or online), and also change the file path for `src` . After that you should be able to go ahead and run `npm run index.js` and you should see the following in your terminal.

```bash
{
  IpfsHash: "QmVLwvmGehsrNEvhcCnnsw5RQNseohgEkFNN1848zNzdng",
  PinSize: 32942,
  Timestamp: "2023-09-08T19:17:41.533Z"
}
```

You can see that the API will return to us the `IpfsHash` or in other words, our CID! You could also extract this as an object for simpler handling like so. 

```jsx
const res = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS",
  formData,
  {
    maxBodyLength: "Infinity",
    headers: {
      "Content-Type": `multipart/form-data; boundary=${formData._boundary}`,
      Authorization: `Bearer ${JWT}`,
    },
  }
);
const { IpfsHash } = res.data
console.log("Your IPFS CID is:", IpfsHash);
```

And this would give you the following

```bash
Your IPFS CID is: QmVLwvmGehsrNEvhcCnnsw5RQNseohgEkFNN1848zNzdng
```

From there you can start using the CID wherever you need it in your decentralized application! 

We hope you found this helpful when it comes to getting your IPFS CID, and of course if you need any help we’re here to talk. Reach out to us through the chat on our [website](https://app.pinata.cloud) or [email us](mailto:team@pinata.cloud), and we can’t wait to see what you build. 

Happy pinning!
