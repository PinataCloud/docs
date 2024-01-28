---
title: "Gateway Access Controls"
slug: "gateway-access-controls"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Jul 18 2023 11:24:49 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Wed Sep 20 2023 20:58:29 GMT+0000 (Coordinated Universal Time)"
---
Pinata's Dedicated Gateways make it possible to fetch and serve IPFS content quickly and reliably, however there can be security risks in exposing your gateway to the world. That is why Pinata has created Gateway Access Controls. These controls will allow you to further limit your gateway,  making sure only your platform is using it. This is accomplished with **Access Tokens, IP Address Restrictions,** and **Host Origin Restrictions.**  

To start, make sure you have a [Dedicated Gateway](doc:dedicated-ipfs-gateways) and then visit the [Access Controls page](https://app.pinata.cloud/developers/gateway-settings) .

By default, Dedicated Gateways are restricted with the lowest level restriction possible. They will only serve content that is pinned to your account. This restriction is helpful for creators and for those just getting started. But if you want to restrict access further, **or if you want to access IPFS content from the wider network that may not be pinned to your account, you'll need to add security restrictions.** 

## Access Tokens

Adding an access token restriction means that content served through your gateway will only be served successfully if the access token is present with the request. **Importantly, you should note that even if the content is pinned to your account, it will not longer serve through your gateway if you have added an access token restriction and don't include that token in requests for content.** 

To create an access token, click on the button that says "Request Token."

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/96e2d66-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_bOs9i9crvT7LbCZPG5cZ_CleanShot_2023-03-21_at_13.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


When you create an access token you will have the ability to preview the token by clicking the "eye" icon, or copy the token to your clipboard with the "copy" icon. At any point you can delete an access token by clicking the three small dots on the right.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f78439b-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_tc4QSpuMOlLqpS6lbRfR_CleanShot_2023-03-21_at_12.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Once you have the token, there are two ways you can use it in the gateway request. 

### Query Parameter

To use the query parameter method, simply add this to the end of a gateway request url:

```
?pinataGatewayToken=PASTE_IN_ACCESS_TOKEN
```

### Header

Another way to use the access token is in the request header. The Key Value would look like this:

| Key                    | Value        |
| ---------------------- | ------------ |
| x-pinata-gateway-token | ACCESS_TOKEN |

**Please keep in mind that using the access token in the request header may not work in a client side application, consider using IP Address restriction instead for those use cases.**

## IP Address

You can also restrict your gateway by IP Address. You can add up to 100 different IP addresses (individually). When you add this restriction, only content requested from an IP address that you've added will be served through your gateway. 

To start click "Set IP Address" on the right side of the menu. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5092ea5-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_MCPILkDpGubZ8EsoCYBw_CleanShot_2023-03-21_at_13.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


You will get window asking for a valid IP Address that will allow any requests being made from the IP Address to go through!

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f32adce-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_yavMxs5mSDwpFH5PBy3T_CleanShot_2023-03-21_at_13.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## Host Origin

With the Host Origin restriction you can make sure your gateway can only be used on a specific Domain like app.pinata.cloud. To get started, click on "Add Host Origin."

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/dad90bc-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_0douTgVfiOPVU3V4b1cc_CleanShot_2023-03-21_at_13.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


After that you can add the domain you would like your gateway to be used from! 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/fffda47-spaces_-MUp92Ia17fU7ZvnMCAm_uploads_QOrv7mHVXoAnAFlYMBeh_CleanShot_2023-03-21_at_13.webp",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


Keep in mind that if you are rendering content on the client side using host origins, you will need to include a `crossorigin` tag in your `img`, `video`, `audio`, `link`, or `script` elements. Here is an example with an img element in React:

```javascript html
<img 
 src="https://pinata-media.mypinata.cloud/ipfs/CID"
 crossorigin='anonymous' 
 alt="pinnie" 
/>
```
```Text React
<img 
 src="https://pinata-media.mypinata.cloud/ipfs/CID"
 crossOrigin='anonymous' 
 alt="pinnie" 
/>
```

For more info on `crossorigin` please read this article [here](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin)!

## Multiple Restrictions

You can add multiple Access Controls and they will perform as an "OR" operator, meaning if you have Host Origins and Access Token set, you can use either one for content to go through.
