---
title: "How to Mint an NFT on Base"
slug: "how-to-mint-an-nft-on-base"
excerpt: "Building with Pinata and Coinbase’s New Ethereum L2"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 19:35:29 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Fri Sep 15 2023 19:35:34 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/beebae2-image.png)

If you’ve been in the crypto space for any amount of time, you likely know Coinbase as one of the leading crypto exchanges. Beyond their work as a crypto exchange, they have done immense work on the front of NFTs, wallets, and now blockchains!

[Base](https://base.org/) is a new Layer 2 blockchain built on Ethereum with the goal of being fast, secure, and open source. Their testnet has been running for several months and just this past month they have released Mainnet, so in this tutorial we’ll show you how to mint an NFT on Base using Pinata.

## Upload Content and Metadata to Pinata

The first thing you’ll need to do is have something to turn into an NFT! As we have always said before, “If you can upload it to Pinata, it can be an NFT.”

We’ll keep it simple and use [this image of Pinnie](https://pinata-media.mypinata.cloud/ipfs/QmVLwvmGehsrNEvhcCnnsw5RQNseohgEkFNN1848zNzdng?filename=pinnie.png). Feel free to use it yourself :)

Next you’ll want to [sign up for a Pinata account](https://app.pinata.cloud/) if you don’t have one already.

![](https://files.readme.io/e9feae8-image.png)

A free account works fine for this tutorial, but if you’re already thinking bigger, you might want to look into [our other plans.](http://pinata.cloud.pricing/)

Once you’re signed in, you can simply upload the image of Pinnie by clicking on “Add Files” in the top right.

![](https://files.readme.io/850554c-image.png)

After it’s been uploaded, click on the CID to copy it and save it for the next step.

![](https://files.readme.io/78b6b55-image.png)

In order to create our NFT we have to put all the information about the NFT into a metadata JSON file. That might sound complicated, but it’s actually quite easy!

You can use [this template on Replit](https://replit.com/@SteveDylan/NFT-Metadata-Template?v=1#metadata.json) (an online code editor) to edit the info for your NFT.

![](https://miro.medium.com/v2/resize:fit:1400/1*WLczQjfryG136YQXA2qMTQ.gif)

Once it’s edited you can save the file by clicking on the “metadata.json” tab and selecting “download.”

![](https://files.readme.io/dd49b09-image.png)

Then upload that metadata file to Pinata just like you uploaded the photo, then copy the CID down for later.

## Setup Coinbase Wallet

![](https://files.readme.io/2bd004f-image.png)

You can use any kind of crypto wallet to complete this tutorial but we would recommend Coinbase for a few reasons.

First, it has a lot of handy stuff baked in, such as the network information for Base and built in testnet faucet. Second, if you happen to have a Coinbase account, it’s super easy to move money back and forth between your account and your wallet.

To setup your wallet visit the [Coinbase Wallet page](https://www.coinbase.com/wallet). Once you have a wallet created we’ll need to do a few things before minting the NFT. First you will need to load it up with 0.002 ETH which at the time of this article is about $5. This is necessary since the Base Göerli testnet faucets have a balance requirement of real money to prevent bot spam which would drain the pools.

After you have some funds added you will need to go to Settings > Developer Settings, and make sure the Testnet toggle is switched on.

![](https://miro.medium.com/v2/resize:fit:1400/1*1KA7oEiao-1jHDTRy7evEw.gif)

To get some testnet funds from the faucet, on that same page you will see Testnet Faucets, then just click on Base Görli. You can only request every 24 hours but we will only need it once for this tutorial.

![](https://miro.medium.com/v2/resize:fit:1400/1*wM1CYX663GAwAIHaSTN5ZA.gif)

## Deploy Smart Contract and Mint NFT

There are a lot of ways to mint an NFT, but for this tutorial we’ll keep it simple by using OpenZeppelin and Remix. Visit [OpenZeppelin’s contract page](https://www.openzeppelin.com/contracts) to use their smart contract builder, give it a name and symbol, and select the following:

![](https://files.readme.io/f20cdd9-image.png)

Of course if you are doing a mainnet contract please do more research on what options to select and make sure you know what you’re putting into your contract.

Once you have those options selected you will want to hit the “Open in Remix” button.

![](https://files.readme.io/bf0150d-image.png)

First thing we need to do in Remix is compile the smart contract which will make sure everything is setup correctly and running smoothly. You can do that by clicking the “Compile” button.

If successful, the icon on the right side should gain a green checkmark.

![](https://files.readme.io/ee12b12-image.png)

Next we will need to deploy the smart contract. To start this click on the “Deploy & Run Transactions” button on the left side.

![](https://files.readme.io/6deae74-image.png)

In order to deploy it to Base Görli we will need to change the environment to “injected.” This should prompt a screen from Coinbase wallet asking which wallet we want to use. After we select Coinbase Wallet, it will give us another prompt to connect our wallet.

![](https://miro.medium.com/v2/resize:fit:1400/1*VChl7DNg-4HjMY6VvLTkXQ.gif)

After the wallet is connected, go back into Coinbase Wallet and click on the network button in the top right.

You’ll see that by default it selects Ethereum, and we will want to switch that to Base Görli instead.

![](https://miro.medium.com/v2/resize:fit:1400/1*RSODRN_wqcmdMeov7ZSi1g.gif)

Now we’re ready to deploy the contract, so just hit that “Deploy” button and confirm the transaction. If the network is busy it might take a second attempt.

![](https://files.readme.io/10da34c-image.png)

If the contract is successfully deployed you will see a log in the bottom saying it worked, and on the left side we will have a new dropdown menu for our deployed contract. Go ahead an click on that to see all the different functions.

![](https://files.readme.io/03d6b0b-image.png)

From this list we will use a function called safeMint which takes two arguments. First it will need the wallet address the NFT will be minted to, and second it will need the “URI” or “Uniform Resource Identifier.”

The URI will be that metadata CID we uploaded to Pinata earlier, so altogether your input for that function will look something like this:

`0xdf71219476f61d2eE6cA8f8Eda335D186d7b233E,ipfs://QmVJUt45cEg4QwuTLtNWN64n7jyzH5moTCaMaWuJm5jJfS`

After putting that data in, click the safeMint button and confirm the transaction. Once it’s gone through you should see a confirmation at the bottom.

![](https://files.readme.io/9d2786f-image.png)

Now you can visit [testnets.opensea.io,](https://testnets.opensea.io/) connect the wallet the NFT was minted to, and you should be able to see it now!

Check out the one we minted with [this link](https://testnets.opensea.io/assets/base-goerli/0x5573609fed21a9e3fed0d5f1f3d4328de31476b9/0) and enjoy it in all it’s based glory ;)

We’re excited to see the possibilities of a L2 chain backed by one of the largest crypto exchanges to create an affordable and secure experience for developers. What will you build with Base and Pinata?

[Grab your Pinata account](https://app.pinata.cloud/) and give this tutorial a spin. Hit me up on Twitter and let me know how it went for you!
