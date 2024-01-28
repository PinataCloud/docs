---
title: "How To Quickly Create An IPFS Powered App With Next.Js"
slug: "how-to-quickly-create-an-ipfs-powered-app-with-nextjs"
excerpt: "Explore the step-by-step process of creating a high-speed IPFS-driven app using Next.js and Pinata, simplifying file sharing and decentralized app creation."
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Sep 15 2023 18:17:32 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Mon Sep 18 2023 19:28:17 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/47aca59-image.png)

When building apps, developers generally just want to get to coding. They don’t want to set up all the scaffolding necessary to begin, but it’s part of life. This is where starter templates make a world of difference. 

Today, we’re going to build a simple app that allows users to upload files from the browser to IPFS. We’ll use Pinata’s free plan to both handle the uploads but also to generate a link to the upload for sharing. To help us with the scaffolding problem, we’ll make use of the [Pinata Next.js Starter Template](https://www.pinata.cloud/blog/announcing-pinata-ipfs-developer-starter-templates). 

## Getting Started

Before we begin, let’s make sure we’re ready to write some code. You’ll need the following: 

- Node.js version 16 or above
- NPM version 8 or above
- A good code editor
- A [Pinata](https://pinata.cloud) account

You can check your Node version from the command line like this: 

```bash
node --version
```

You can check your NPM version similarly: 

```bash
npm --version
```

When you’re ready to sign up for your free Pinata account, [head over to Pinata’s pricing page](https://pinata.cloud/pricing) and select the free plan. And that’s it. You’re ready to code. 

## Creating the Scaffolding

From the command line be sure to switch into the directory where you have all your dev projects. Now, we’re going to create a new project called `simple-ipfs`. From the command line, run the following command: 

```bash
npx create-pinata-app
```

This will kick off the CLI tool and you’ll be prompted to answer some questions. First, give your app a name (simple-ipfs). Next, decide if you want to be working in TypeScript or JavaScript. I’ll choose JavaScript for this tutorial to keep it simple. Finally, you’ll be asked if you want to use Tailwind with your project. I’m going to choose Yes, but you don’t have to. 

 Within a few seconds, you should have a new project ready to code. Switch into the new project directory: 

```bash
cd simple-ipfs
```

Then, open the project in your code editor of choice. We need to set up our environment variables file. You’ll notice there is an `.env.sample` file. We’ll just copy that file and re-name it to `.env.local`. In the file, you’ll see three variables. The first two are the only two required variables, but we’ll talk about the other variable shortly. 

Let’s start by getting our Pinata JWT. To do this, you should log into your Pinata account. Once you’re logged in, go to the API Key link on the left sidebar. Here, you can create a new key. You’ll need to copy the JWT you receive and paste it in after the `=` sign in your `.env.local` file for the variable `PINATA_JWT`. You can create an admin key for this project, but if you want to learn about creating API keys with granular scopes, [you can read more here](https://www.pinata.cloud/blog/how-to-use-scoped-api-keys-with-ipfs-app-development). 

Next, you’ll want to get the URL to your [Dedicated IPFS gateway](https://www.pinata.cloud/blog/what-is-an-ipfs-gateway). [This guide](https://www.pinata.cloud/blog/how-to-use-dedicated-gateways) explains how to do so and what Dedicated Gateways can do. Every Pinata account comes with a Dedicated Gateway. On paid plans, your access levels and bandwidth restrictions are much higher, but for the sake of this app, the Free plan should work fine. When you have your Dedicated Gateway URL, add it to your `.env.local` file the same way you added your JWT. 

The last variable in the `.env.local` file is optional unless you are looking to fetch content from the IPFS network that you have not pinned yourself. This app will require uploading and and pinning content, so we don’t need to make use of the `NEXT_PUBLIC_GATEWAY_TOKEN` variable. 

With those variables in place, we’re ready to fire up the app. Run the following from your command line: 

```bash
npm run dev
```

When you visit `[localhost:3000](http://localhost:3000)` in your browser, you should see a page like this: 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/de8baa7-Untitled.png",
        null,
        "Untitled"
      ],
      "align": "center"
    }
  ]
}
[/block]


This is nice, but let’s build our own simple uploader and routing system to share file details.

## Building The App

Our app is a simple uploader that allows you to share a link with others to download the file that is shared. With that in mind, let’s design our entry page. It should have a an upload button, and we should allow the user to give the upload a name and a description. 

If you open the `pages/index.js` file, you’ll see there’s a lot of good stuff here already, including a file input element and a function to handle the upload. We don’t want to gut the entire thing, but we definitely need to change some things up. So, let’s replace that entire file with: 

```javascript
import { useState, useRef } from "react";
import Head from "next/head";
import Files from "@/components/Files";

export default function Home() {
  const [file, setFile] = useState("");
  const [cid, setCid] = useState("");
  const [uploading, setUploading] = useState(false);
  const [form, setForm] = useState({
    name: "",
    description: "",
  });

  const inputFile = useRef(null);

  const uploadFile = async (e) => {
    try {
      e.preventDefault();
      setUploading(true);
      const formData = new FormData();
      formData.append("file", file, { filename: file.name });
      formData.append("name", form.name);
      formData.append("description", form.description);
      const res = await fetch("/api/files", {
        method: "POST",
        body: formData,
      });
      const ipfsHash = await res.text();
      setCid(ipfsHash);
      setUploading(false);
    } catch (e) {
      console.log(e);
      setUploading(false);
      alert("Trouble uploading file");
    }
  };

  const handleChange = (e) => {
    setFile(e.target.files[0]);
  };

  const loadRecent = async () => {
    try {
      const res = await fetch("/api/files");
      const json = await res.json();
      setCid(json.ipfs_pin_hash);
    } catch (e) {
      console.log(e);
      alert("trouble loading files");
    }
  };

  return (
    <>
      <Head>
        <title>Simple IPFS</title>
        <meta name="description" content="Generated with create-pinata-app" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/pinnie.png" />
      </Head>
      <main className="m-auto flex min-h-screen w-full flex-col items-center justify-center">
        <div className="m-auto flex h-full w-full flex-col items-center justify-center bg-cover bg-center">
          <div className="h-full max-w-screen-xl">
            <div className="m-auto flex h-full w-full items-center justify-center">
              <div className="m-auto w-3/4 text-center">
                <h1>Share files easily</h1>
                <p className="mt-2">
                  With Simple IPFS, you can upload a file, get a link, and share
                  it with anyone who needs to access the file. The link is
                  permanent, but it will only be shared once.
                </p>
                <input
                  type="file"
                  id="file"
                  ref={inputFile}
                  onChange={handleChange}
                  style={{ display: "none" }}
                />
                <div className="mt-8 flex flex-col items-center justify-center rounded-lg bg-light p-2 text-center text-secondary">
                  <button
                    disabled={uploading}
                    onClick={() => inputFile.current.click()}
                    className="align-center flex h-64 w-3/4 flex-row items-center justify-center rounded-3xl bg-secondary px-4 py-2 text-light transition-all duration-300 ease-in-out hover:bg-accent hover:text-light"
                  >
                    {uploading ? (
                      "Uploading..."
                    ) : (
                      <div>
                        <p className="text-lg font-light">
                          Select a file to upload to the IPFS network
                        </p>
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                          strokeWidth={1.5}
                          stroke="currentColor"
                          className="m-auto mt-4 h-12 w-12 text-white"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5m-13.5-9L12 3m0 0l4.5 4.5M12 3v13.5"
                          />
                        </svg>
                      </div>
                    )}
                  </button>
                </div>
                {file && (
                  <form onSubmit={uploadFile}>
                    <div className="mb-2">
                      <label htmlForm="name">Name</label><br/>
                      <input onChange={(e) => setForm({
                        ...form, 
                        name: e.target.value
                      })} className="border border-secondary rounded-md p-2 outline-none" id="name" value={form.name} placeholder="Name" />
                    </div>
                    <div>
                      <label htmlForm="description">Description</label><br />
                      <textarea
                        className="border border-secondary rounded-md p-2 outline-none"
                        value={form.description}
                        onChange={(e) => setForm({
                          ...form, 
                          description: e.target.value
                        })}
                        placeholder="Description..."
                      />                      
                    </div>
                    <button className="rounded-lg bg-secondary text-white w-auto p-4" type="submit">Upload</button>
                  </form>
                )}
                {cid && <Files cid={cid} />}
              </div>
            </div>
          </div>
        </div>
      </main>
    </>
  );
}
```

We re-used a lot of the functionality that came out of the box, but we re-styled the app to match our personal flavor, and we changed the upload functionality to take a form submission with a name and description for the file. I won’t spend time going through the UI code because it’s, well, UI. However, pay attention to the `uploadFile` function and the `loadRecent` function (which is not currently used). These functions are calling our Next.js serverless backend. The `loadRecent` function will be used later on a different page, but we’ll hang on to it here for a bit. 

Since we are passing metadata about our file to our serverless function, we need to make a minor tweak to the existing out-of-the-box code that comes with the starter template API. Open up the `pages/api/files.js` file and find the line that says: 

```jsx
const response = await saveFile(files.file);
```

We’re going to update that to: 

```jsx
const response = await saveFile(files.file, fields);
```

This is taking the fields that were passed through as part of the multipart formdata upload from the frontend and using them in the `saveFile` function. We’ll need to update that function as well. So find it in the code and update it to look like this: 

```jsx
const saveFile = async (file, fields) => {
  try {
    const stream = fs.createReadStream(file.filepath);
    const options = {
      pinataMetadata: {
        name: fields.name,
        keyvalues: {
          description: fields.description
        }
      },
    };
    const response = await pinata.pinFileToIPFS(stream, options);
    fs.unlinkSync(file.filepath);

    return response;
  } catch (error) {
    throw error;
  }
};
```

All we’ve changed here is adding the name and a keyvalue pair for the description. This data is not stored on IPFS but is a nice convenience layer provided by Pinata. When we load the file, we can show this info in-app. 

Now, you may have noticed in the `pages/index.js` file there was a component that is called `Files`. We haven’t changed that yet, but we’re going to. That component displays a [content identifier (CID)](https://www.pinata.cloud/blog/what-is-an-ipfs-cid) for the file uploaded and a link to view the file. We want to change this to display a link that can be shared with others that is a page within our app. 

Let’s open up the `components/Files.jsx` file. We want to show the CID for the file but also include a copy button that will share the link to the file. Currently, this component has the CID and a link to view or download the file directly from a Dedicated Gateway. Let’s make some changes. Update the component to look like this: 

```jsx
import React from "react";

export default function Files(props) {
  const copyLink = async () => {
    const copyText = `${window.location.origin}/${props.cid}`;
    await navigator.clipboard.writeText(copyText);
    alert("Copied: " + copyText);
  };

  return (
    <div
      onClick={copyLink}
      className="m-auto mt-8 flex w-3/4 cursor-pointer flex-row justify-around rounded-lg"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        strokeWidth={1.5}
        stroke="currentColor"
        className="h-6 w-6"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z"
        />
      </svg>

      <p>{props.cid}</p>
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        strokeWidth={1.5}
        stroke="currentColor"
        className="h-6 w-6"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M8.25 7.5V6.108c0-1.135.845-2.098 1.976-2.192.373-.03.748-.057 1.123-.08M15.75 18H18a2.25 2.25 0 002.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 00-1.123-.08M15.75 18.75v-1.875a3.375 3.375 0 00-3.375-3.375h-1.5a1.125 1.125 0 01-1.125-1.125v-1.5A3.375 3.375 0 006.375 7.5H5.25m11.9-3.664A2.251 2.251 0 0015 2.25h-1.5a2.251 2.251 0 00-2.15 1.586m5.8 0c.065.21.1.433.1.664v.75h-6V4.5c0-.231.035-.454.1-.664M6.75 7.5H4.875c-.621 0-1.125.504-1.125 1.125v12c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V16.5a9 9 0 00-9-9z"
        />
      </svg>
    </div>
  );
}
```

The first thing you might notice are the SVG elements. We’re using some SVG icons from Heroicons, a great open source icon library, to help make this component look nice. We’ve got a share icon and a copy icon with the file’s CID in between. 

We’re breaking the rules of semantic HTML in order to get through this tutorial quickly by adding a click handler to our DIV element. You should use a button element or the appropriate Aria props for accessibility in production. Our DIV click handler simply copies the URL to share with others. 

Notice in the `copyLink` function we are building the link assuming there will be another page in our app that points to the CID. Let’s build this page.

In the `pages` folder of your project, add a new file called `[cid].js`. This is a way to tell Next.js that the file will use [dynamic routing](https://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes). Basically, anything after the forward-slash in your domain, in this case, would use this page. 

Inside your `pages/[cid].js` file, add the following: 

```jsx
import Head from 'next/head';
import React, { useRef, useState, useEffect } from 'react'
import mime from 'mime';

const GATEWAY_URL = process.env.NEXT_PUBLIC_GATEWAY_URL
  ? process.env.NEXT_PUBLIC_GATEWAY_URL
  : "https://gateway.pinata.cloud";

const CID = ({ fileData }) => {
  const [href, setHref] = useState("");
  const downloadRef = useRef(null);

  useEffect(() => {
    if(href) {
      downloadRef.current.click();
    }
  }, [href]);
  
  const download = async () => {
    const res = await fetch(`${GATEWAY_URL}/ipfs/${fileData.ipfs_pin_hash}?download=true`);    
    const extension = mime.getExtension(res.headers.get('content-type'))
    const blob = await res.blob();

    const supportsFileSystemAccess =
      'showSaveFilePicker' in window &&
      (() => {
        try {
          return window.self === window.top;
        } catch {
          return false;
        }
      })();
    // If the File System Access API is supported…
    if (supportsFileSystemAccess) {
      try {        
        const handle = await showSaveFilePicker({
          suggestedName: `${fileData.ipfs_pin_hash}.${extension}`,
        });        
        const writable = await handle.createWritable();
        await writable.write(blob);
        await writable.close();
        return;
      } catch (err) {        
        if (err.name !== 'AbortError') {
          console.error(err.name, err.message);
          const blobUrl = URL.createObjectURL(blob); 
          setHref(blobUrl);   
        }
      }
    }
  }

  return (
    <>
      <Head>
        <title>Simple IPFS</title>
        <meta name="description" content="Generated with create-pinata-app" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/pinnie.png" />
      </Head>
      <main className="m-auto flex min-h-screen w-full flex-col items-center justify-center">
        <div className="m-auto flex h-full w-full flex-col items-center justify-center bg-cover bg-center">
          <div className="h-full max-w-screen-xl">
            <div className="m-auto flex h-full w-full items-center justify-center">
              <div className="m-auto w-3/4 text-center">
                <h1>Download file</h1>
                <p className="mt-2">
                  Please make sure you trust the source of this link. If you don't know who sent you the link and are unsure what will be downloaded, do not click the download button.
                </p>
                <a className="hidden" href={href} ref={downloadRef} download={fileData.originalName} />
                <div className="mt-8 flex flex-col items-center justify-center rounded-lg bg-light p-2 text-center align-center flex h-64 w-3/4 m-auto flex-row items-center justify-center rounded-3xl bg-secondary px-4 py-2 text-light transition-all duration-300 ease-in-out hover:bg-accent hover:text-light">
                  <h2 className="text-3xl">{fileData.metadata.name}</h2>
                  <h3 className="mb-8">{fileData.metadata.keyvalues.description}</h3>
                  <button                    
                    onClick={download}
                    className="underline"
                  >
                    Download
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </>
  )
}

export async function getServerSideProps(context) {
  const pinataSDK = require("@pinata/sdk");
  const pinata = new pinataSDK({ pinataJWTKey: process.env.PINATA_JWT });
  // Fetch data from external API    
  const response = await pinata.pinList(    
    {
      hashContains: context.query.cid
    }
  );
  
  const fileData = response.rows[0];
  return { props: { fileData } }
}

export default CID
```

There’s a lot going on in this file, but we’ll walk through it. Let’s start at the bottom since the code in the `getServerSideProps` function runs server-side before any of the client code is rendered. [This is a Next.js function](https://nextjs.org/docs/pages/building-your-application/data-fetching/get-server-side-props) that allows you to make data requests that will hydrate the frontend with the response. 

In our `getServerSideProps` function, we are importing the Pinata SDK and using a non-public environment variable (just like we did in our serverless function API route) to use the SDK. We are querying for the CID of the file we shared, and that CID is contained in the URL. 

With our result, we pass it as props that are ultimately available in our client-side component. We use the props to render the name and description of our file from the Pinata metadata. We also have a download link that triggers the `download` function. 

This function first makes a request to the Gateway you set in your environment variables earlier to download the file into memory. We then grab the headers to identify what type of file it is through the `content-type` property. With that, we use a library called `mime` to map that content-type to a file extension. Next, the function checks to see if the browser supports the [File System API](https://developer.mozilla.org/en-US/docs/Web/API/File_System_API). If it does, we display a download modal with a pre-populated file name and extension. And if the browser doesn’t support the File System API, we trigger a hidden link in the component and redirect to the file’s link in the browser. It will either display the file if supported by the browser, or it will download the file to the user’s computer. 

When a user opens the share link you send them in a browser, they will have a description shown to them and the option to download. If they download the file, they can rename it if they wish and choose where on their computer it gets stored. 

[block:html]
{
  "html": "<video muted autoplay style=\"width: 100%; height: auto; position: relative;\">\n    <source src=\"https://mktg.mypinata.cloud/ipfs/QmXPe6jq7nqeJCSWMmwvZLA8D9u4UpPtsSpUutwMsr8U6Y?filename=video.mp4\" type=\"video/mp4\">\n</video>"
}
[/block]


And that’s it! The whole app creation was accelerated massively by starting with the Next.js template from Pinata. 

## Wrapping Up

Next.js is one of the most popular frameworks for building React apps. IPFS is the number one storage solution for off-chain data. Now, the two are combined in an easy to use start template. This particular example uses serverless functions to upload files. This can be tricky because of the limits platforms like Vercel and AWS have on serverless functions payload size. If you want to upload larger files, stay tuned for a future tutorial where we show you how to create a signed token to do uploads right from the client safely. 

If you want to see the full code for this app, you can [find it on Github here](https://github.com/PinataCloud/simple-ipfs). 

Until then, happy pinning!
