---
title: "Pinata CLI"
slug: "pinata-cli"
excerpt: ""
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Mon Aug 07 2023 13:11:54 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Mon Aug 14 2023 16:26:53 GMT+0000 (Coordinated Universal Time)"
---
## What is this?

This is a simple command line tools designed to allow developers (and those familiar with the command line) to easily upload files and folders to their Pinata account. It is specifically built to help with large folder uploads. 

## How to use this CLI

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FYQMktd0llOo%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DYQMktd0llOo&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FYQMktd0llOo%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=YQMktd0llOo",
  "title": "How to use the Pinata CLI",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/YQMktd0llOo/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=YQMktd0llOo",
  "typeOfEmbed": "youtube"
}
[/block]


Make sure you are using a recent version of Node. We recommend `14.17.6` or above.

First, you have to install it.

`npm i -g pinata-upload-cli`

Once it's installed, you will be able to check all the functionality by running: 

`pinata-cli -h` 

You can upload files and folders using this CLI, and you can upload them to the public IPFS network through Pinata.

To upload to the public IPFS network, you'll need a [Pinata API Key JWT](ref:datatestauthentication). 

## Usage

Authenticate Public IPFS: 

```
pinata-cli -a [Pinata JWT]
```

Upload a folder or file to public IPFS: 

```
pinata-cli -u ../../../test/folder/relative/path
```
