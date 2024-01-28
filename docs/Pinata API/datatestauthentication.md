---
title: "Authentication"
slug: "datatestauthentication"
excerpt: "Basics of how to authenticate with the Pinata API"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 07 2023 19:48:22 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Thu Sep 21 2023 00:49:29 GMT+0000 (Coordinated Universal Time)"
---
To connect to the Pinata API, you will need to generate Pinata API Keys. Visit the [Pinata API Keys](https://app.pinata.cloud/developers/api-keys) page to generate new keys.

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2Fl4vPAeBtdms%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3Dl4vPAeBtdms&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2Fl4vPAeBtdms%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=l4vPAeBtdms",
  "title": "How to Create a Pinata API Key",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/l4vPAeBtdms/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=l4vPAeBtdms",
  "typeOfEmbed": "youtube"
}
[/block]


When you click "New API Key" you will be prompted to select permissions and the number of uses for the key you generate. Admin privileges, as you might expect, have access to all API endpoints. If you'd like to specify specific endpoints, you can do so by expanding the endpoint's parent route and toggling on the permission.

![](https://files.readme.io/1758e56-Screenshot-Arc-08-04-2023-12-582x.png)

By default, all keys have unlimited use. However, if you'd like to limit the number of times a key can be used, you can do so by setting the Max Uses field.

By setting a Key Name, you will be able to easily identify the key and its purpose.  
Any key can have its access revoked by clicking the Revoke button. Once a key has been revoked, it can no longer be utilized for any purpose.

# Important

When you generate your keys, you will see a modal with the **Pinata API Key**, **Pinata API Secret**, and the **JWT**.

![](https://files.readme.io/572eca6-Screenshot-Arc-08-04-2023-12-122x.png)

Your "Pinata API Key" acts as your public key for our REST API, and your "Pinata Secret API Key" acts as the password for your public key. The JWT is an encoded mix of the two. Be sure to keep your secret key private.

For added customer security, these keys are encrypted on Pinata's side and will only ever be displayed once, **so write them down**. If you lose these values you'll need to revoke the key and create a new one.

# Connecting to the Pinata API

The base URL for Pinata requests is: <https://api.pinata.cloud>  
You have two ways of connecting to the Pinata API:

- Bearer Authentication
- Custom Headers

To use the bearer authentication model, you will need the JWT that is generated when creating API keys. This token can be used as an Authorization header for all your API requests in the following format:

```
"Authorization": "Bearer YOUR_JWT"
```
