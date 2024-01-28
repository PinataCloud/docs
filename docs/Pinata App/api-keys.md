---
title: "API Keys"
slug: "api-keys"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Wed Aug 09 2023 15:39:34 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Sep 12 2023 17:19:16 GMT+0000 (Coordinated Universal Time)"
---
This page is where you can create, record, and delete API keys for the [Pinata API](ref:pinningpinfiletoipfs). Creating an API is very simple! Just visit the page to start by click on the API Keys button in the left sidebar, then click "New Key" in the top right. 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/0da6d78-navigate-to-api-keys-page.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


In the New Key modal you can choose if you want the key to be an Admin key and have full access over every endpoint, or scope the keys by selecting which endpoints you want to use. You can also give it a limited number of uses, and be sure to give it a name to keep track of it. Once you have that filled out click "Create Key" and it will show you the `pinata_api_key`, `pinata_api_secret_key`, and the `JWT`. It's best to click "Copy All" and keep the API key data safe and secure. 

> 🚧 Once API keys have been created, you will not be able to see the secret or JWT again

![](https://mktg.mypinata.cloud/ipfs/Qmd1EE4Nk7fKVL6d8T6hy5JoKaXNXWCvNpNKNWeCJ6LHf5?filename=api.gif)

_(and yes, we deleted these keys 😉)_

Once you have created your keys you can go ahead and try testing them! You can even use them in our [API Reference section](ref:get_data-testauthentication) :eyes: Or feel free to paste this into your terminal with your `JWT`

```curl cURL
curl --request GET \
     --url https://api.pinata.cloud/data/testAuthentication \
     --header 'accept: application/json' \
     --header 'authorization: Bearer YOUR_PINATA_JWT'
```

If successful you should see this! 

```shell bash
{  
  "message": "Congratulations! You are communicating with the Pinata API!"  
}
```

## Managing Keys

From the Keys Page you can see the name of a key, the public key, when it was issues, how many max uses it has, and what permissions it was given. 

![](https://files.readme.io/7330306-Screenshot-Arc-09-08-2023-20-072x.png)

At any point you can delete an API key by clicking on the Revoke button 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1f0d9b1-revoke-api-key.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]
