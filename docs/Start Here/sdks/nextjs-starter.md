---
title: "Next.js Starter"
slug: "nextjs-starter"
excerpt: "A Pinata + Next.js web app template using the Pinata SDK"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Mon Aug 07 2023 13:12:29 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Aug 22 2023 00:42:13 GMT+0000 (Coordinated Universal Time)"
---
If you're planning on using Pinata inside of a web application, this template is a great way to get started. Pinata uses the builtin Next.js `api` routes to keep your API keys secure, and we make it easy to spin up! 

## Getting Started

[block:embed]
{
  "html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fwww.youtube.com%2Fembed%2FTaJzw_2hEJI%3Ffeature%3Doembed&display_name=YouTube&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DTaJzw_2hEJI&image=https%3A%2F%2Fi.ytimg.com%2Fvi%2FTaJzw_2hEJI%2Fhqdefault.jpg&key=7788cb384c9f4d5dbbdbeffd9fe4b92f&type=text%2Fhtml&schema=youtube\" width=\"854\" height=\"480\" scrolling=\"no\" title=\"YouTube embed\" frameborder=\"0\" allow=\"autoplay; fullscreen; encrypted-media; picture-in-picture;\" allowfullscreen=\"true\"></iframe>",
  "url": "https://www.youtube.com/watch?v=TaJzw_2hEJI",
  "title": "How to Use the Pinata + NEXT.js Template",
  "favicon": "https://www.google.com/favicon.ico",
  "image": "https://i.ytimg.com/vi/TaJzw_2hEJI/hqdefault.jpg",
  "provider": "youtube.com",
  "href": "https://www.youtube.com/watch?v=TaJzw_2hEJI",
  "typeOfEmbed": "youtube"
}
[/block]


### API Keys and Gateway

If you haven't already, visit the [keys page](https://app.pinata.cloud/developers/api-keys) and create an API key. You can also follow the instructions in [Getting Started](doc:getting-started). 

You can also use your own Dedicated Gateway domain, which you can get from the [Gateways page](doc:gateways).

### Starting Up the App

Create a new Pinata project using this command:

```
npx create-pinata-app
```

Follow the prompts in the command line to create the project. Once complete, change into the new project directory and run the app with the following command:

```
npm run dev
```

You can edit the `pages/index.js` file and the API route file `pages/api/files` to see the Pinata functionality and extend it or make changes.

### Environment Variables

This project makes use of both public and private environment variables. The private environment variables are used to protect sensitive data like your Pinata API keys. The public environment variables are convenient central variable housing.

Read more about [how environment variables work with Next.js here](https://nextjs.org/docs/pages/building-your-application/configuring/environment-variables).

There is a `.env.sample` file you can copy and rename to `.env.local` for use in your project. Be sure to fill out the environment variable values in the `.env.local` file with your actual values.

### Learn More

For more information about building apps with Pinata and IPFS, check out the following resources:

- [Pinata Docs](https://docs.pinata.cloud)
- [Pinata Tutorials](https://medium.com/pinata)
- [Quick Start Recipes](https://docs.pinata.cloud/recipes)
