---
title: "How to Create an ERC-6551 iFrame"
slug: "how-to-create-an-erc-6551-iframe"
excerpt: "Step-by-step tutorial for displaying your ERC-6551 wallet and its assets with custom iFrames"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 18:44:21 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Fri Sep 15 2023 19:19:29 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/5d9ab27-image.png)

ERC-6551 has already been noted as a groundbreaking Ethereum implementation that gives ERC-721 NFTs their own wallets, allowing them to own tokens, other NFTs, or even interact with other smart contracts.

This gives NFTs a breath of fresh air and layers of interactivity for industries like gaming and music. **The only problem is that because the standard is so new, there are not any marketplaces or wallets that can display an ERC-6551 wallet or the assets inside of it.**

Thanks to Tokenbound you can use their custom iFrame implementation to display it on your own website, or even through the NFT’s metadata via OpenSea which is what this tutorial will show you how to do.

You will need a little bit of developer experience to launch this project. Tools being used would include a text editor, smart contracts, GitHub, and Vercel to launch the site. Don’t worry, even if you’re a novice this guide should be able to walk you through each step so you can implement it.

## Mint an NFT

In some ways this step is optional, but for this tutorial we’ll mint an NFT with the objective of being able to update the token URI (the primary info about the NFT).

This is totally optional because you can use the Token Bound Account iFrame on its own. We’ll be using the animation_url property in the NFT metadata so it’ll show up on marketplaces like OpenSea. We also have a tutorial walking through this process you can view [here](https://youtu.be/YkfMXquwVn4).

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


The first thing we need to do is upload whatever we want our NFT to be to Pinata.

We’ll upload our classic Pinnie.png so we can send it some surprises later 👀. To upload, visit app.pinata.cloud and sign in with your account. If you don’t have an account you can sign up with a free account to start.

![](https://files.readme.io/e17b01e-image.png)

After logging in you can upload a file by clicking “Add Files,” then select the file, give it a name if you want, and click “Upload.”

![](https://miro.medium.com/v2/resize:fit:1400/1*4p3jgOQVQdplK7FfytlVxg.gif)

Once the file is uploaded you should see it listed on the files page. You will want to copy the CID and save it for later.

Next we need to make a metadata JSON file that will hold all the information about our NFT. It will look something like this:

```json
{  
  "name": "Name of NFT",  
  "description": "Description of NFT",  
  "external_url": "<https://pinata.cloud">,  
  "image": "ipfs://CID_GOES_HERE"  
}
```

You can copy this and edit it to your liking, but make sure to replace CID_GOES_HEREwith the CID of the image you uploaded. You can also edit the file with this [Replit template](https://replit.com/@SteveDylan/NFT-Metadata-Template#metadata.json) and save the file to your computer from there.

After you have saved it you will want to upload that file to Pinata as well, just like the image. Be sure to copy the CID for that metadata file and save it for later.

Now that our assets are ready we can create our smart contract to mint the NFT. There are a lot of ways to mint an NFT, but for this guide we’ll use a combination of OpenZeppelin and Remix.

Visit [OpenZeppelin’s Smart Contracts](https://www.openzeppelin.com/contracts) page to start and you should see a contract builder with some different options. In order to have an NFT that can accept a ERC-6551 Token Bound Account, we need to select ERC-721.

![](https://files.readme.io/0392cf4-image.png)

At the top you can give it a `Name` and `Token Symbol`, and be sure to leave the `Base URI` empty. From there you can select which options you would like, and for this guide we’ll select the following:

![](https://files.readme.io/74f519c-image.png)

After you have everything set, click on the “Open in Remix” button.

![](https://files.readme.io/4f55aea-image.png)

We’re going to make one small addition to our smart contract. This function will allow us to update the Token URI for a specific NFT. It’s very subjective if this is a good practice or not, but for our application we want to be able to add an `animation_url` to our NFT metadata later on so our ERC-6551 iFrame will show up on OpenSea.

The importance is that this is in the smart contract for anyone to see, and updates to an NFT are all recorded on chain. With that said you will want to put this function after `safeMint`.

```sol
function setTokenURI(uint256 tokenId, string memory uri) public onlyOwner {
   _setTokenURI(tokenId, uri);
}
```

![](https://files.readme.io/bd9e864-image.png)

After adding the function we can go ahead and compile the contract by clicking the “Compile contract” button on the left side. If successful you should see a green check mark on the left side bar for the Solidity Compiler.

![](https://files.readme.io/0aa0284-image.png)

Next we will want to navigate to the “Deploy & Run Transactions” tab on the sidebar.

![](https://files.readme.io/0fe0de3-image.png)

Before we deploy this smart contract, you will want to make sure you have the right wallet with testnet funds and network selected.

Inside the “Deploy & Run Transactions” screen there will be a dropdown menu in the top right to select your environment. Click that and select “Injected Provider — Metamask” (it might be different if you use a different wallet).

![](https://files.readme.io/4f7d536-image.png)

Doing so should prompt you to connect your wallet. After that is done you can click the “Deploy” button and sign the transaction with your wallet.

![](https://files.readme.io/ec0842b-image.png)

If successful you should see a contract listed under “Deployed Contracts” with a toggle to expand it and see all the different functions.

We’re going to use the safeMint function, and if you click the toggle button for that you will see it takes two arguments: a wallet address the NFT will be sent to, and the Token URI for the NFT. URI stands for “Unified Resource Identifier,” which is exactly what that metadata.json file does that we uploaded to Pinata earlier. To reference it we’ll use the IPFS protocol URI which looks something like this.

```text
ipfs://CID_GOES_HERE
```

When we put our CID in the place holder and combine it with our wallet address, it will look something like this.

![](https://files.readme.io/df38265-image.png)

After those two fields are filled you can go ahead and click the “Transact” button and it will prompt your wallet for a signature.

If successful you should see a checkmark in the bottom log, and you can visit testnets.opensea.io, connect your wallet there, and see the NFT that was just minted.

![](https://files.readme.io/8336add-image.png)

## Create an ERC-6551 Token Bound Account for your NFT

We won’t go into this step as it’s pretty simple. For a full guide check out either [this blog post](https://medium.com/pinata/how-to-create-an-erc-6551-token-bound-account-for-your-nft-f71a4478ae17) which is a quick no code solution, or follow the following video that will show you how to deploy ERC-6551 smart contracts yourself for a more technical approach.

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FGLTVd5P5LCw%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DGLTVd5P5LCw&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FGLTVd5P5LCw%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=GLTVd5P5LCw",
  "title": "How To Create a Tokenbound Account (ERC-6551)",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/GLTVd5P5LCw/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=GLTVd5P5LCw",
  "typeOfEmbed": "youtube"
}
[/block]


In essence you will need to create a Token Bound Account (TBA) for the NFT in question so we can use it in the ERC-6551 iFrame.

It also would be beneficial to send your new TBA some assets like a testnet currency or some NFTs. In our example we’ll send it this fun ERC-1155 NFT of some Pinata clouds.

![](https://files.readme.io/da8e324-image.png)

## Create the ERC-6551 iFrame

Since this is such a new standard for NFTs there aren’t really any marketplaces that will be able to show and render if an NFT has a Token Bound Account or if that account has any assets. **That’s where the ERC-6551 iFrame comes into play.**

A way around this problem of not being able to show off TBAs is to use the `animation_url` property in the NFT metadata standards. Just like how we can provide an image link for an NFT, with the `animation_url` we can use a link to a video, an audio file, or even a whole application.

Pinata has mentioned these possibilites before with the concept of [App NFTs](https://medium.com/pinata/how-to-build-an-app-nft-7c57b51698e7), and in a way the ERC-6551 will let you implement an app into your NFT to give it enhanced display powers.

Setting up your iFrame will be pretty simple. We’ll be using GitHub and Vercel to deploy this iFrame, but feel free to use the repo in whatever services or frameworks you feel comfortable with.

The first thing you will need is an Alchemy API key. You can get this by visiting [Alchemy.com](https://alchemy.com/) and signing up for a free account. Once you are signed in you will want to visit the Apps page by clicking on the left sidebar, then click on “Create New App.”

![](https://files.readme.io/e61974f-image.png)

From there you will want to select the blockchain and network you want to use. For this one we can simply do the Ethereum blockchain using the Göerli testnet, give it a name and description, and click “Create App.”

![](https://files.readme.io/914d682-image.png)

Once created you will want to click on the “API Key” button from the app dashboard and keep it somewhere safe.

Now that we have our API key we can start preparing the iFrame. Visit the [Tokenbound iFrame repo on GitHub](https://github.com/tokenbound/iframe/tree/main) and fork it with your own account.

![](https://files.readme.io/077e20a-image.png)

Once it’s forked you can head over to [Vercel](https://vercel.com/). If you don’t already have an account you can create a free one and connect your GitHub account. From the main screen you will want to click “Add new…” and select “Project.”

![](https://files.readme.io/ff1e3d3-image.png)

If your GitHub is connected you should see your fork of the Tokenbound iFrame listed where you can select “Import.”

![](https://files.readme.io/7e510fb-image.png)

Before you deploy, you will want to paste in a few important environment variables, including the API keys you received earlier. In the repo there is an `.env.example` file that has the following information.

```text
NEXT_PUBLIC_ALCHEMY_KEY=
NEXT_PUBLIC_ALCHEMY_KEY_POLYGON=
NEXT_PUBLIC_PROVIDER_ENDPOINT=
NEXT_PUBLIC_CHAIN_ID=1
NEXT_PUBLIC_TOKENBOUND_ADDRESS=0x02101dfB77FDE026414827Fdc604ddAF224F0921
NEXT_PUBLIC_IMPLEMENTATION_ADDRESS=0x2d25602551487c3f3354dd80d76d54383a243358
NEXT_PUBLIC_SALT=0
NEXT_PUBLIC_MAX_TOKEN_ID=15000
NEXT_PUBLIC_NXYZ_API_KEY=
NEXT_PUBLIC_NXYZ_ENDPOINT="https://api.n.xyz/api/v1"
#CUSTOM IMPLENTATION
NEXT_PUBLIC_NFT_ENDPOINT=
SENTRY_AUTH_TOKEN=
```

The only one you need to worry about is the the `NEXT_PUBLIC_ALCHEMY_KEY`. Paste in the API keys, and the beauty of Vercel is you can copy the whole `.env` file contents, click on the “Environment Variables” tab, select the first row, and just paste.

It will automatically fill out all the details from the file so you don’t have to go back and forth. Once that’s done you can hit “Deploy.”

![](https://miro.medium.com/v2/resize:fit:1400/1*ZwkPf2TuSEvM9vqzEFYNuw.gif)

After its complete you will see a dashboard with the URL of the project. With it you can start trying out the iFrame by simply following this pattern:

```text
https://vercel-deployment-url.vercel.app/<contractAddress>/<tokenId>/<<chainId><chainId>
```

The subdomain of your Vercel app will depend on what you set it as or what it automatically gave you, but feel free to customize it or use a custom domain to match your project branding.

To use it just add on the contract address for the NFT you minted earlier, the token ID, and the chain ID which in this case will be 5 for Göerli. The result should look something like this.

```text
https://iframe-tokenbound.vercel.app/0x6a5c1bd3301ce086972bbbb7e1fd2220c4832437/33/5
```

![](https://miro.medium.com/v2/resize:fit:1400/1*HOo6jNEfgU8fHLKfLVuQtQ.gif)

## Update Token URI

Now that we have an app running our ERC-6551 iFrame, we can add it into our NFT metadata. For this step you will want to open that metadata.json file again and add a new line called `animation_url` like so.

```json
{  
  "name": "Name of NFT",  
  "description": "Description of NFT",  
  "external_url": "https://pinata.cloud", 
  "image": "ipfs://CID_GOES_HERE",  
  "animation_url": "https://iframe-tokenbound.vercel.app/0x6a5c1bd3301ce086972bbbb7e1fd2220c4832437/33/5"  
}
```

You will want to upload this new updated metadata CID to Pinata just like you did before and you will receive a new CID.

Take that CID and go back to the smart contract in Remix, and look for that custom function we made called `setTokenURI.` It’s really simple, all we need to do is provide the token ID for the NFT that we’re going to update, and then provide the new CID for the metadata.json file.

![](https://files.readme.io/ef0330b-image.png)

Go ahead and submit the transaction and sign it with your wallet, and if successful we should be all set.

Now you can go back to OpenSea and request them to update the metadata, which will cause them to reindex that particular NFT smart contract. After a few minutes it should update and show the ERC-6551 iFrame instead of just the NFT image!

![](https://miro.medium.com/v2/resize:fit:1400/1*Zj7o77-ubAXlQqkh7mt-pw.gif)

That wraps up this guide on how to use ERC-6551 iFrames, but it’s truly only the beginning. By using the basics in the iFrame you could build out your own applications that interact with Token Bound Accounts, like a game that has an NFT character with an interactive inventory, or a music album with multi media inside of it.

Now it’s your turn! [Grab your Pinata account](http://pinata.cloud/pricing) and give this tutorial a try. We’re excited to see what developers will create with this new Ethereum standard!
