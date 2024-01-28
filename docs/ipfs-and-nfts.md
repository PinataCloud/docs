---
title: "IPFS and NFTs"
slug: "ipfs-and-nfts"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Sep 12 2023 19:54:56 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Sep 12 2023 21:05:43 GMT+0000 (Coordinated Universal Time)"
---
Pinata has been empowering the NFT space since 2018 and there's a good reason for that. IPFS is the perfect pairing for NFTs for several reasons. 

- **IPFS is Immutable** - Anything that is uploaded to IPFS cannot change, which helps preserve the value of an NFT.
- **IPFS is Decentralized** - Instead of using a centralized server where one person can control the content, IPFS is distributed and makes sure anyone can pin the content and keep it persisted.
- **IPFS is Portable** - Since the [CID](doc:cids) for content will be constant, and IPFS pinning works in a decentralized manner, anyone can take a CID and pin it themselves. This allows content to be "transferred" and kept up on the network as people value it. (read more about that concept [here](https://medium.com/pinata/who-is-responsible-for-nft-data-99fb4e8147e4))

One of the biggest reasons you want to use IPFS for NFTs is to prevent tampering or "rug pulls" where someone can just delete the data for an NFT and make it worthless. NFTs are tokens on the blockchain that have a "Token URI" which is simply a link pointing to data about that NFT off-chain, because putting data on-chain is far too expensive. If this link is a centralized server, like `https://server.com/pinnie.png`, then whoever has control of the server can simply upload totally different content and keep the same name, thus keeping the same link. Or they could just delete it and it would be empty! 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d3778ac-homepage-new_fonts_3.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


This is where IPFS becomes necessary. Since the address or link to the content on IPFS is the [CID](doc:cids), which is based on the content itself and is immutable, you can't change it or alter it. In addition, the ability for multiple people to [pin](doc:ipfs-pinning) content and help it persist on the network makes it harder for something to just be deleted.

## How to Make an NFT with Pinata

It's important to note that Pinata is currently not providing any minting services. This means you would use Pinata to host the media content and the metadata for the NFT, and then another service or self-deployed smart contract to actually mint the NFT. But don't worry, we'll show you a few different ways you could do that! 

### Step 1: Upload the Content

The first thing you need to do is upload the content to Pinata. Since IPFS supports any kind of file, the truth is any kind of file can be an NFT. How that file is referenced in the metadata is a bit of a different story, so be sure to check [metadata standards](https://docs.opensea.io/docs/metadata-standards) to make sure you content will be seen on marketplaces or wallets. 

To upload the content you can either do a simple upload through the Pinata App by navigating to the [files page](doc:files-page) and uploading through the UI like so:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/df585b0-app-upload.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Or you can upload through the [API](ref:post_pinning-pinfiletoipfs) using a script like this:

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

pinFileToIPFS()
```

In each case you will want to grab the CID for that file, which will look something like this:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/932ba94-Doc_Snippets_4.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


### Step 2: Create and Upload Metadata

Now that we have the CID for our content on IPFS, we need to create a metadata file that will have all the other information about the NFT. You will want to use a JSON format and follow [industry metadata standards](https://docs.opensea.io/docs/metadata-standards) to make sure that it will show up in marketplaces and wallets. You can use the template below as we'll walk through each piece.

```json metadata.json
{
  "name": "Name of NFT",
  "description": "Description of NFT",
  "external_url": "https://pinata.cloud",
  "image": "ipfs://CID_GOES_HERE"
}
```

- `name` - This will be the name of this particular NFT, not the collection. 
- `description` - Describes the NFT.
- `external_url` - A link to the website of the NFT project or creator.
- `image` - This would be the link to the image, if it was a video or gif then you would want to follow metadata standards and have a backup image, and also add an `animation_url` for the video. 

You'll notice that we are using the IPFS protocol URL for the image link. There are other ways to reference CIDs in NFT metadata which you can read about more [here](https://docs.pinata.cloud/docs/cids#how-do-i-reference-cids).  

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/620f987-Doc_Snippets_5.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Once you have that file filled out you will want to save it as something like `metadata.json` (this might be different if you are making a large project using folders). Then you can upload the metadata file to Pinata using the app like before, or if you are using the API we have a [JSON endpoint](ref:post_pinning-pinjsontoipfs) you can use to simplify the process, like so:

```javascript pinJSONToIPFS
const axios = require('axios')
const FormData = require('form-data')
const fs = require('fs')
const JWT = 'Bearer PASTE_YOUR_PINATA_JWT'

const pinJSONToIPFS = async () => {
  
  const data = JSON.stringify({
    pinataContent: {
      name: "Pinnie NFT",
      description: "A nice NFT of Pinnie the Pinata",
      external_url: "https://pinata.cloud",
      image: "ipfs://bafkreih5aznjvttude6c3wbvqeebb6rlx5wkbzyppv7garjiubll2ceym4"
    },
    pinataMetadata: {
      name: "metadata.json"
    }
  })
  
    try{
      const res = await axios.post("https://api.pinata.cloud/pinning/pinJSONToIPFS", data, {
        headers: {
          'Content-Type': 'application/json',
          Authorization: JWT
        }
      });
      console.log(res.data);
    } catch (error) {
      console.log(error);
    }
}

pinJSONToIPFS()
```

After the metadata is uploaded you should now have a CID for that metadata file; this will be the core identity of your NFT and will act as the **Token URI**.

### Step 3: Mint the NFT

Now that you have the all important Token URI metadata CID, you can mint an NFT! How you go about doing this will depend on multiple factors. 

#### Starting an NFT Project

If you are non-technical and you're just looking for the easy way to create an NFT project, you will likely want to use a minting service like [Bueno](https://bueno.art), [Mintplex.xyz](https://mintplex.xzy), or [Manifold](https://manifold.xyz). There are a lot of complexities with smart contracts and making sure the content is setup properly, and using a service like this will make things much easier!  

#### Just Exploring NFTs

If you want to get your feet wet with smart contracts you could follow the video below! It covers the Base layer 2 blockchain in particular, but the method will work on other EVM chains. 

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FYkfMXquwVn4%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DYkfMXquwVn4&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FYkfMXquwVn4%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=YkfMXquwVn4",
  "title": "How to Mint an NFT on Base",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/YkfMXquwVn4/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=YkfMXquwVn4",
  "typeOfEmbed": "youtube"
}
[/block]


#### Implementing into an Decentralized App

If you are a developer that is trying to do NFT minting on a larger scale, you could use an NFT minting API like [Crossmint](https://crossmint.com). Lucky for you we have some tutorials on how to do just that! 

[block:tutorial-tile]
{
  "backgroundColor": "#6e57ff",
  "emoji": "✨",
  "id": "64afd432c6670f00377e8d77",
  "link": "https://docs.pinata.cloud/v1.0/recipes/mint-an-nft-with-pinata-and-crossmint",
  "slug": "mint-an-nft-with-pinata-and-crossmint",
  "title": "Mint an NFT with Pinata and Crossmint"
}
[/block]


[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FLTFRD-eEc5Y%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DLTFRD-eEc5Y&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FLTFRD-eEc5Y%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=LTFRD-eEc5Y",
  "title": "How to Mint an NFT With APIs Using Crossmint and Pinata",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/LTFRD-eEc5Y/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=LTFRD-eEc5Y",
  "typeOfEmbed": "youtube"
}
[/block]
