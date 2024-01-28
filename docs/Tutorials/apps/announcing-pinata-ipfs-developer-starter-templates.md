---
title: "Announcing Pinata IPFS Developer Starter Templates"
slug: "announcing-pinata-ipfs-developer-starter-templates"
excerpt: "Discover how to accelerate your development with IPFS-based projects using the create-pinata-app starter template. Simplify uploads and protect API keys."
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 19:38:33 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Mon Sep 18 2023 19:28:34 GMT+0000 (Coordinated Universal Time)"
---
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7476b41-Announcing_Pinata_IPFS_Developer_Starter_Templates.png",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


One of the fastest ways to get started with new technology and one of the most convenient ways to create a new project with technology you already know is to start from a template. Some boilerplate code helps get you started, reminds you how everything works together, and can accelerate your development time. React may be the most famous early example with the `create-react-app` script that would spin up a React project that was ready to both run locally and edit in your favorite code editor to match your project’s needs. Since then, many developer platforms have followed suit. And we’re excited to announce that we’re also creating a simple way for developers to spin up new IPFS-based projects. 

## Introducing create-pinata-app

Starting today, developers have an easy way to build fullstack applications that leverage IPFS through Pinata’s APIs. The starter template is built on Next.js, a popular and scalable solution for React projects. Your Pinata API keys will be protected and only used on the serverless backend functions of the Next.js project. And the upload logic is already wired up. So, you can just focus on building your app. 

To create a new project, simply fire up your terminal and run: 

`npx create-pinata-app`

You’ll be guided through the creation of a JavaScript or TypeScript project with vanilla CSS or Tailwind CSS included. Getting started with Pinata now only takes ~20 seconds.

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmRvqmi2nnepJjwj3eri5ZX9EdFLn8w1SQYXP3UehyySv1?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


What do you get out of the box?

You get the Pinata SDK embedded into your app. You get upload functionality that sends your uploaded file to the backend serverless function and passes it along to IPFS through Pinata’s API. You get a button and an API call to load the most recently uploaded file. Check it out!

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmQvPMG7k9yqYXGDubwmkiP8xca9y3w3XrYzhAnCT8qPuw?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


## Why did we build this?

We want Pinata’s developer tools to be the most frictionless experience in web3 and beyond. Our API was originally built as an answer to cumbersome IPFS solutions in the early days of blockchain developer interest in the protocol. Our SDK took that a step further. We’ve built other tools to help improve on the Pinata developer experience, but this is a major step forward. 

Through conversations with customers, it also became clear that uploading files without exposing API keys was a challenges. Many developers wanted a simple solution and would turn to uploading files directly from the client to Pinata. This was simple but dangerous. This starter template provides all the tools and code to protect API keys while still giving developers a simple experience for uploads (and other API calls). 

We’re excited to see what developers build as we continue to make their lives easier. Web3 and development in general is hard enough. Pinata is the easiest way to build IPFS-powered applications. 

Happy pinning!
