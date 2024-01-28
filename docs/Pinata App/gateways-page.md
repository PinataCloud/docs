---
title: "Gateways"
slug: "gateways-page"
excerpt: "https://app.pinata.cloud/gateway"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 28 2023 18:40:40 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Wed Sep 13 2023 16:16:11 GMT+0000 (Coordinated Universal Time)"
---
The Gateways page is where you can create and manage [Dedicated Gateways](doc:dedicated-ipfs-gateways) from your Pinata account. For more info on how to use them check out [this page](doc:dedicated-ipfs-gateways). 

When you sign up for a Pinata plan you will receive an automatically generated dedicated gateway with a random subdomain, and it will be listed on the page with a bandwidth meter. 

![](https://files.readme.io/73cc467-Screenshot-Arc-07-29-2023-00-072x.png)

If you don't see a gateway, you can make one by clicking "Create Gateway" which will let you choose an available subdomain.  

## Bandwidth

At the top of the page you can see how much of your bandwidth allowance you have used for the month. This refreshes after every billing cycle. You can also view this info on the [Billing and Usage page](doc:billing-and-usage).

## Access

By default all Dedicated Gateways are restricted, meaning they will only allow through CIDs that are pinned to your account. This prevents abuse from people who would try to use the gateway for their own purposes and drive up your bandwidth and requests. Dedicated Gateways can be opened by using [Gateway Access Controls](doc:gateway-access-controls), which allow CIDs outside the account to go through but only when an access control is met. If you have a Gateway Access Control on a gateway, it will be listed as "Open" on this page. 

## Custom Domains

You can use your own custom domain so the gateway could be used to match your branding, e.g. `https://coolwebsite.com/ipfs/<CID>`. To do this, click on the options button on the right side of a gateway and click "add custom domain." 

![](https://files.readme.io/ab5870a-Screenshot-Arc-07-29-2023-00-162x.png)

This will prompt you to type in the domain you want to use. After doing so and refreshing the page, click on the options button again to see the domain info. 

![](https://files.readme.io/6619207-Screenshot-Arc-07-29-2023-00-262x.png)

This will give you a DNS record you will need to enter in through your domain provider (e.g. Namecheap, GoDaddy). It typically follows the format of:

[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Host (subdomain)",
    "h-2": "Value",
    "0-0": "CNAME",
    "0-1": "@ or any other subdomain you pick (e.g. www)",
    "0-2": "The original name of the gateway followed by a period  \n`aquamarine-casual-tarantula-177.mypinata.cloud.`"
  },
  "cols": 3,
  "rows": 1,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]


![](https://files.readme.io/df27904-Screenshot-Arc-07-29-2023-00-542x.png)

## Setting Gateway Root

A unique feature on [Dedicated Gateways](doc:dedicated-ipfs-gateways) is the ability to set a file as the gateway root. It's a simple redirect of a gateway root url to a specific CID you have designated. For instance, if you visit `https://pinata-media.mypinata.cloud` you would be redirected to `https://pinata-media.mypinata.cloud/ipfs/QmVLwvmGehsrNEvhcCnnsw5RQNseohgEkFNN1848zNzdng`. This is create for websites hosted on Pinata or smaller projects (like [this cool photo zine](https://www.pinata.cloud/blog/how-to-create-a-weekly-photo-zine)).

To set a file as the gateway root, simply go to the [Files Page](doc:files-page) and click on "more" for the desired file, then click "Set as gateway root."

![](https://files.readme.io/efb0fcd-image.png)

## Removing a Gateway

If for any reason you want to delete a gateway, simply click on the options button and click "Remove Gateway."

![](https://files.readme.io/f46beec-Screenshot-Arc-07-29-2023-00-412x.png)
