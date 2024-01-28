---
title: "Getting Started"
slug: "getting-started"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Jul 18 2023 11:12:50 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Wed Sep 13 2023 15:54:20 GMT+0000 (Coordinated Universal Time)"
---
> 🚧 **Disclaimer:**
> 
> Please be aware that IPFS is a **public** network! This means anything uploaded through Pinata will be accessible by anybody on the network.

## 1. Sign up for a Pinata Account

If you haven't already, [sign up for a free account here](https://app.pinata.cloud/register) 

_Have a look at our flexible pricing plans_ [_here_](https://www.pinata.cloud/pricing)_._

## 2. Generate your API Keys

Pinata offers developer keys for various scenarios. The most common scenario is normal IPFS actions (pinning content, unpinning, listing content, etc). These actions happen through the core Pinata API, and are documented in the [Pinata API Reference](ref:pinningpinfiletoipfs).

To create an API key, visit the [Keys Page](https://app.pinata.cloud/developers/keys) and click the "New Key" button in the top right. Once you do that you can select if you want your key to be admin or if you want to scope the privileges of the keys to certain endpoints or limit the number of uses. Make those selections, then give the key a name at the bottom, and click create key. 

> 📘 If you are just getting started we recommend using Admin privileges, then move to scope keys as you better understand your needs

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/490bc38-new-key-creation.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Once you have created the keys you will be shown your API Key Info. This will contain your **Api Key**, **API Secret**, and your **JWT**. Click "Copy All" and save them somewhere safe! 

> 📘 The API keys are only shown once, be sure to copy them somewhere safe!

## 3. Upload a File to Pinata

With your API key you can upload a file to Pinata by either copying the code snippet below, or following the Recipe! 

> 📘 For simplicity use the Pinata JWT you received when creating your API keys!

[block:tutorial-tile]
{
  "backgroundColor": "#0152f4",
  "emoji": "⬆️",
  "id": "64c463cb434c14005acd41ca",
  "link": "https://pinata-cloud-tech.readme.io/v1.0/recipes/upload-a-file-to-pinata",
  "slug": "upload-a-file-to-pinata",
  "title": "Upload a File to Pinata"
}
[/block]


```javascript pinFileToIPFS.js
const axios = require('axios')
const FormData = require('form-data')
const fs = require('fs')
const JWT = 'Bearer PASTE_YOUR_PINATA_JWT'

const pinFileToIPFS = async () => {
    const formData = new FormData();
    const src = "path/to/file.png";
    
    const file = fs.createReadStream(src)
    formData.append('file', file)
    
    const pinataMetadata = JSON.stringify({
      name: 'File name',
    });
    formData.append('pinataMetadata', pinataMetadata);
    
    const pinataOptions = JSON.stringify({
      cidVersion: 0,
    })
    formData.append('pinataOptions', pinataOptions);

    try{
      const res = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS", formData, {
        maxBodyLength: "Infinity",
        headers: {
          'Content-Type': `multipart/form-data; boundary=${formData._boundary}`,
          Authorization: JWT
        }
      });
      console.log(res.data);
    } catch (error) {
      console.log(error);
    }
}

```

## 4. Fetch the File through a Gateway

After uploading a file you should get a response that looks like this

```json
{
  "IpfsHash": "bafkreih5aznjvttude6c3wbvqeebb6rlx5wkbzyppv7garjiubll2ceym4",
  "PinSize": 32942,
  "Timestamp": "2023-06-16T17:24:37.998Z"
}
```

With the `IpfsHash` you can view the file or fetch the data using an IPFS Gateway, which acts as a bridge between the IPFS protocol and the HTTP protocol. You can fetch a file by using your own [Dedicated Gateway](doc:dedicated-ipfs-gateways) like so!

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/decfbcd-Doc_Snippets.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## 5. Party!! :tada:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/cb2864f-excited-new-year-gif.gif",
        null,
        ""
      ],
      "align": "center",
      "sizing": "100% "
    }
  ]
}
[/block]


You have completed the core fundamentals of Pinata, which is easily uploading content to be used on IPFS and fetching it through a gateway. With these you can build apps like marketplaces, minting platforms, and more!
