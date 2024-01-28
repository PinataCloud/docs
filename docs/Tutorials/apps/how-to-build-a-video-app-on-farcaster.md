---
title: "How To Build A Video App on Farcaster"
slug: "how-to-build-a-video-app-on-farcaster"
excerpt: "Using IPFS, Pinata, and FarcasterJS"
hidden: false
createdAt: "Fri Sep 15 2023 19:48:30 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Nov 21 2023 19:40:40 GMT+0000 (Coordinated Universal Time)"
---
![](https://files.readme.io/c1645e3-image.png)

When Twitter first came out, you had to text to tweet. The data was open and the API was open. Application developers loved being able to plug into what was feeling like a protocol-level experience and build their own apps on top of it. However, Twitter soon began locking down their APIs, shutting off access that had once been open, and killed off (intentionally or not) many apps.

This proves two things. First, and probably most important, is that developers will build creative things atop open data when given the opportunity. Second, starting with a protocol and expanding to applications is key to maintaining that open data. This is where [Farcaster](https://farcaster.xyz/) comes in.

Farcaster is an open protocol for social networks. The definition of social here is broad. The initial implementation of the protocol is entirely closed, but the data is open. The goal is to curate a community around the protocol through an application built atop the protocol and then expand access to the protocol beyond the initial curation process. The open data element is Farcaster’s most powerful tool. It also aligns with the open data model of IPFS.

Today, we’re going to use the protocol as it works at the time of this writing—invite-only, single storage hub, but open data—and we’re going to build a short video sharing app in the spirit of Vine.

We’re going to keep this incredibly MVP, meaning it will be slow. Instead of indexing the entire protocol, which is possible with tools like this and will become easier when independent hubs are launched, we will index just the posts that have video content for Absorb. Any other client on the Farcaster protocol can access these posts and build entirely different experiences with them if they want.

Let’s get started!

## Getting Started

**If at any point you get stuck or something doesn’t quite work correctly, you can consult the final repository of code here: <https://github.com/polluterofminds/farcaster-vine-tutorial>** 

For this tutorial, we’ll be using Next.js. [You can reference their getting started guide](https://nextjs.org/docs/getting-started), but as long as you have Node.js installed along with NPM, you should be in good shape.

You’ll also need a Farcaster account. At the time of this writing, Farcaster is in private beta. Hit Farcaster creator [Dan Romero up on Twitter](https://twitter.com/dwr) via DM and tell him you’d love access and you’re working on a tutorial to build a Farcaster based application.

Of course to upload you will want a Pinata account. The free plan is pretty generous however if you ever want to go to production, you may want to consider a paid plan. Either way, [sign up for an account here](https://pinata.cloud/pricing).

Once you’ve signed up for your Pinata account, you’re going to need to generate API keys so that we can upload content.  [Here’s how you can generate API keys after signing into Pinata.](doc:api-keys)

We’ll use the JWT from the API keys. With that available, let’s start our project.

You’ll also need a free Alchemy API key. [Sign up for a free account here](https://www.alchemy.com/). Then create an app for Ethereum on the Goerli testnet. You’ll be presented with an API key that you can use there.

## Creating The Front End

Next.js is an integrated React frontend and serverless backend framework. We’ll use the serverless backend to do things like upload new videos and delete videos.

To start our project, open up your terminal tool of choice and change into the directory where you keep all those `NODE_MODULES` — I mean dev projects. Any directory will do really. Then from the terminal, run:

`npx create-next-app farcaster-vine`

When you app is created, change into the directory. Before we begin, let’s scope out what the front end part of this app needs to do.

- Connect to an Ethereum-based wallet provider
- Fetch data from the Farcaster protocol
- Post media to Pinata
- Render videos through an IPFS gateway

To get started, let’s install a bunch of dependencies we’ll need for the above. Run the following command from your terminal:

`npm i @pinata/sdk @standard-crypto/farcaster-js @ethersproject/providers @ethersproject/wallet wagmi axios formidable`

For some simple styling (we won’t be going wild in this tutorial), let’s use TailwindCSS. You can find the [framework guide for Next.js here](https://tailwindcss.com/docs/guides/nextjs). But for simplicity, you should be able to run this command in your terminal:

```shell
npm install -D tailwindcss postcss autoprefixer  
npx tailwindcss init -p
```

Then, in the root of your project, find the `tailwind.config.js` file, and change it to look like this:

```
/** @type {import('tailwindcss').Config} \*/  
module.exports = {  
  content: \[  
    "./pages/**/_.{js,ts,jsx,tsx}",  
    "./components/\*\*/_.{js,ts,jsx,tsx}",  
  ],  
  theme: {  
    extend: {},  
  },  
  plugins: \[],  
}
```

And finally, open the `styles/global.css` file and replace everything in there with this:

```
@tailwind base;  
@tailwind components;  
@tailwind utilities;
```

Now that we have some baked in CSS we can use, let’s make it possible to connect an Ethereum wallet to sign messages (this is how you will authenticate and prove that you have access to Farcaster). We’ll use the `wagmi` library to make this easy. Open up your `pages/_app.tsx` and add the following:

```javascript
import '../styles/globals.css'  
import type { AppProps } from 'next/app'  
import { WagmiConfig, createClient, configureChains, goerli } from 'wagmi'  
import { alchemyProvider } from 'wagmi/providers/alchemy'  
import { publicProvider } from 'wagmi/providers/public'  
import { CoinbaseWalletConnector } from 'wagmi/connectors/coinbaseWallet'  
import { InjectedConnector } from 'wagmi/connectors/injected'  
import { MetaMaskConnector } from 'wagmi/connectors/metaMask'  
import { WalletConnectConnector } from 'wagmi/connectors/walletConnect'

const { chains, provider, webSocketProvider } = configureChains(  
  [goerli],  
  [  
    alchemyProvider({ apiKey: 'YOUR_ALCHEMY_GOERLI_KEY' }),  
    publicProvider(),  
  ]  
)

const client = createClient({  
  autoConnect: true,  
  connectors: [  
    new MetaMaskConnector({ chains }),  
    new CoinbaseWalletConnector({  
      chains,  
      options: {  
        appName: 'wagmi',  
      },  
    }),  
    new WalletConnectConnector({  
      chains,  
      options: {  
        qrcode: true,  
      },  
    }),  
    new InjectedConnector({  
      chains,  
      options: {  
        name: 'Injected',  
        shimDisconnect: true,  
      },  
    }),  
  ],  
  provider,  
  webSocketProvider,  
})

export default function App({ Component, pageProps }: AppProps) {  
  return (  
    <WagmiConfig client={client}>  
      \<Component {...pageProps} />  
    </WagmiConfig>  
  )  
}
```

This is the entry file for our entire Next.js app. We are creating a client that will pass its functionality to all components within the app here with our `WagmiConfig`. In the example, I’ve configured the app to handle Metamask, Coinbase, and then pretty much any other wallet through WalletConnect. Check the [wagmi docs](https://wagmi.sh/) for more info on what options are available for configuration.

What we’ve set ourselves up for here is to be able to access wallet functionality (specifically signing functionality that we’ll need later). Now, we can leave this alone and move on you building our our app’s layout.

Let’s build out the scaffolding. In the `pages/index.js` file, add the following:

```javascript index.js
import Feed from '../components/Feed'  
import Header from '../components/Header'  
import axios from 'axios';

export default function Home() {  
  const loadPosts = async () => {

  }  
  return (

   <div className="w-full">
    <Header loadPosts={loadPosts} />
    <Feed />
   </div>
  )
}
```

That’s it? Yep! This is a very basic example that you will hopefully take and run with. But for the tutorial, you’ll just have a feed and a header. We’ll finish the `loadPosts` function later. But we should probably create those components, right?

Let’s start with the `Feed` component. This will be placeholder for now and we’ll come back to it when we know what our posts will look like. In the root of your project, create a folder called `components`. Then inside that folder, add a file called `Feed.tsx`. Inside that file, add the following:

```java Feed.tsx
import React from "react";

const Feed = () => {
  return <div className="mt-20">Feed</div>;
};

export default Feed;
```

Not much happening here yet, so let’s move on. Now, we’ll work on the `Header`. In the components folder of your project, add a file called `Header.tsx`. Inside that file, add the following:

```javascript Header.tsx
import React, { useState, useEffect } from 'react'  
import { fetchProfile, generateAuthToken, getAuthTokenFromFC } from '../utils/farcaster';  
import { useSignMessage, useAccount } from 'wagmi';  
import { utils } from "ethers";  
import { getMediaRecorder } from '../utils/mediaRecorder';  
import AuthModal from './AuthModal';  
import axios from 'axios';

const mimeType = 'video/webm'

type props = {  
  loadPosts: () => void;  
}

const Header = (props:props) => {  
  const { loadPosts } = props;  
  const [caption, setCaption] = useState("");  
  const [recording, setRecording] = useState<boolean>(false);  
  const [recordView, setRecordView] = useState<boolean>(false);  
  const [previewUrl, setPreviewUrl] = useState<string>("");  
  const [showAuthModal, setShowAuthModal] = useState<boolean>(false);  
  const [user, setUser] = useState<any>(null);  
  const [strm, setStream] = useState<any>(null);  
  const [amount, setAmountOfCameras] = useState<number>(0);  
  const [mediaRecorder, setMediaRecorder] = useState<any>(null)  
  const [time, setTime] = useState(6)  
  const [blobData, setBlob] = useState<any>(null)  
  const [posting, setPosting] = useState(false)

  const { address, connector, isConnected } = useAccount();  
  const { data, error, isLoading, signMessage } = useSignMessage({  
    async onSuccess(data, variables:any) {  
      const sig = Buffer.from(utils.arrayify(data)).toString("base64");  
      const auth = await getAuthTokenFromFC(`Bearer eip191:${sig}`, variables.message)  
      localStorage.setItem("fc-token", JSON.stringify(auth));  
      getUser()  
    },  
  });

  useEffect(() => {  
    if(recordView) {  
      getMediaRecorder(previewUrl, setAmountOfCameras, strm, setStream);  
    }  
  }, [recordView]);

  const recordVideo = async () => {  
    //  Check if user is signed in and has a Farcaster account  
    //  If so, allow recording. If not, post alert  
    const user = await checkAuth();  
    const profile = await fetchProfile();  
    if(!user || !profile) {  
      isConnected && address ? getNewAuthToken() : setShowAuthModal(true);  
    } else {  
      setUser(profile);  
      setRecordView(true);  
    }  
  }

  const checkAuth = async () => {  
    let user = JSON.parse(localStorage.getItem("fc-profile") || "");  
    return user;  
  };

  const getNewAuthToken = async () => {  
    const payload = generateAuthToken();  
    signMessage({message: payload})  
  }

  const getUser = async () => {  
    try {  
      const user = await fetchProfile();  
      if(user) {  
        localStorage.setItem("fc-profile", JSON.stringify(user));  
        setUser(user);  
        setRecordView(true);  
      } else {  
        alert("User not found");  
        return null;  
      }  
    } catch (error) {  
      console.log(error);  
      alert("User not found");  
      return null;  
    }  
  }

  const handleRecord = async () => {

  }

  const cancel = () => {  
    setStream(null);  
    setRecordView(false);  
    setRecording(false);  
    setPreviewUrl("");  
  }

  const handleUpload = async () => {

  }

  return (  
    <div className="w-full">  
      <div className="flex flex-row justify-between row between w-full">  
        <p>Pinnie's Video Feed</p>  
        <button onClick={recordVideo}>Record New Video</button>  
      </div>  
      {  
        recordView &&  
        <div className="fixed top-20 h-full w-full m-auto bg-white">  
          \<video  
            className={!previewUrl ? 'hidden' : 'm-auto w-3/4'}  
            id="preview"  
            autoPlay  
            loop  
            controls  
            playsInline  
            src=""  
            muted={true}  
          />{' '}  
          \<video  
            className={previewUrl ? 'hidden' : 'm-auto w-3/4'}  
            autoPlay  
            playsInline  
            id="video"  
            src=""  
            muted={true}  
          />  
        {  
          previewUrl ?  
          <div>  
            <button onClick={handleUpload}>Post Video</button><button onClick={cancel}>Cancel</button>  
          </div> :  
          <div>  
            <button onClick={handleRecord}>Record</button>  
          </div>  
        }  
        </div>  
      }  
      {  
        showAuthModal &&  
        <AuthModal />  
      }  
    </div>  
  )  
}

export default Header;
```

Let’s walk through this file to make sure we understand what’s going on. First, it’s clear we’re going to need to create some new functions and files. Don’t worry, we’ll do that. We also are hard-coding the mimeType at the top of the file. In the Chrome browser, your video recording is going to be encoded as webm. For other browsers, you should set this to mp4.

Outside of that, we can see there are a bunch of state variables we’ll be using. There are some wagmi hooks we’ll be making use of, and we’re leveraging the React useEffect hook to conditionally create a media recorder.

Beneath that, we have a few functions that will take care of checking to see if we are authenticated with Farcaster, getting a new auth token for Farcaster, fetching a user profile from localStorage, setting a user profile to localStorage, recording, uploading, and cancelling.

In the body of the React component, we are showing the header with our app’s name and a record button. We conditionally render the video elements for our recording. If we are recording, we render one element. If we have recorded and need to preview before uploading, we render another video element. We also have a check to see if we should show the AuthModal or not. The AuthModal is another component we will create. Some of the functions we mentioned earlier are stubbed out, and we’ll fill them in later.

To finish off our components, let’s create the AuthModal. This modal will allow the user to connect their wallet and sign in. In your components folder, create a file called `AuthModal.tsx` and add the following:

```javascript AuthModal.tsx
import { useEffect, useState } from "react";
import { useConnect, useAccount } from "wagmi";

type props = {
  setShowAuthModal: (status: boolean) => void,
};

export default function AuthModal(props: props) {
  const { setShowAuthModal } = props;
  const [showConnector, setShowConnector] = useState(false);
  const { isConnected } = useAccount();
  const { connect, connectors, isLoading, pendingConnector } = useConnect();

  useEffect(() => {
    if (isConnected) {
      setShowAuthModal(false);
    }
  }, [isConnected]);

  const connectWallet = () => {
    setShowConnector(true);
  };

  return (
    <div className="fixed inset-0 z-10 overflow-y-auto">
      <div className="flex flex-col min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
        <div>
          <div className="mt-3 text-center sm:mt-5">
            <h3 className="text-lg font-medium leading-6 text-gray-900">
              Connect Your Farcaster Account
            </h3>
            <div className="mt-2">
              <p className="text-sm text-gray-500">
                In order to post new videos or interact with existing videos on
                Absorb, you must have a Farcaster account. Connect your wallet
                to begin.
              </p>
            </div>
          </div>
        </div>
        {!showConnector && (
          <div className="mt-5 sm:mt-6 sm:grid sm:grid-flow-row-dense sm:grid-cols-2 sm:gap-3">
            <button onClick={connectWallet} type="button">
              Connect Wallet
            </button>
            <button type="button" onClick={() => setShowAuthModal(false)}>
              Cancel
            </button>
          </div>
        )}

        {showConnector && (
          <div className="mt-5 sm:mt-6 sm:grid sm:grid-flow-row-dense sm:grid-cols-2 sm:gap-3">
            {connectors.map((connector) => (
              <button
                disabled={!connector.ready}
                key={connector.id}
                type="button"
                onClick={() => connect({ connector })}
              >
                {connector.name}
                {!connector.ready && " (unsupported)"}
                {isLoading &&
                  connector.id === pendingConnector?.id &&
                  " (connecting)"}
              </button>
            ))}
            <button type="button" onClick={() => setShowAuthModal(false)}>
              Cancel
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

```

Once again, we’re using the hooks from the `wagmi` library to help us with all things wallet management. We check to see if the user’s wallet is connected. If it is, we’re good to go. If it’s not, they can choose from available wallet options and select one. We get all of this out of the box from `wagmi`.

Ok, that’s done. You’ll see it in action soon. But now we need to create the file that will handle our media recorder functionality.

Create a utils folder in the root of your project directory. Then, inside that folder, add a file called `mediaRecorder.ts`. Inside that file, add the following:

```javascript mediaRecorder.ts
export const getMediaRecorder = async (
  previewUrl: string,
  setAmountOfCameras: (device: number) => void,
  strm: any,
  setStream: (stream: any) => void
) => {
  if (!previewUrl) {
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices
        .getUserMedia({
          audio: false,
          video: true,
        })
        .then(function (stream) {
          stream.getTracks().forEach(function (track) {
            track.stop();
          });

          getDeviceCount().then(function (deviceCount: any) {
            // setAmountOfCameras(deviceCount);

            // init the UI and the camera stream
            setAmountOfCameras(deviceCount);
            initCameraStream("user", strm, setStream);
          });
        })
        .catch(function (error) {
          if (error === "PermissionDeniedError") {
            alert("Permission denied. Please refresh and give permission.");
          }

          console.error("getUserMedia() error: ", error);
        });
    } else {
      alert(
        "Mobile camera is not supported by browser, or there is no camera detected/connected"
      );
    }
  }
};

export const getDeviceCount = () => {
  return new Promise(function (resolve) {
    var videoInCount = 0;

    navigator.mediaDevices
      .enumerateDevices()
      .then(function (devices: any) {
        devices.forEach(function (device: any) {
          if (device.kind === "video") {
            device.kind = "videoinput";
          }

          if (device.kind === "videoinput") {
            videoInCount++;
            console.log("videocam: " + device.label);
          }
        });

        resolve(videoInCount);
      })
      .catch(function (err) {
        console.log(err.name + ": " + err.message);
        resolve(0);
      });
  });
};

const initCameraStream = (
  mode: string,
  stream: any,
  setStream: (strm: any) => void
) => {
  if (stream) {
    stream.getTracks().forEach(function (track: any) {
      console.log(track);
      track.stop();
    });
  }

  let constraints = {
    audio: true,
    video: {
      width: 1080,
      height: 1920,
      facingMode: mode,
      aspectRatio: { exact: 1.7777777778 },
    },
  };

  navigator.mediaDevices
    .getUserMedia(constraints)
    .then((stream) => {
      const video: any = document.getElementById("video");
      if (video) {
        video.srcObject = stream;
      }

      setStream(stream);

      const track = stream.getVideoTracks()[0];
      const settings = track.getSettings();
      const str = JSON.stringify(settings, null, 4);
      console.log("settings " + str);
    })
    .catch(handleError);
};

function handleError(error: any) {
  console.error("getUserMedia() error: ", error);
  alert("Error getting media");
}

```

Here’s what we’re doing in this file:

We’re checking to ensure the user’s device has at least one camera (usually a safe bet that there’s a user-facing camera). For simplicity, we are only enabling and giving access to the user-facing camera. We’re setting some constraints that help us set the aspect ratio of the video to be recorded. Once that’s set, we are opening up a video stream with audio support. We assign that stream to a state variable we passed into the function so that we can use it elsewhere. We are also getting our video element from the html and setting the stream as the source for the element.

After you’ve created this file, it won’t do anything. If you remember, back in our `Header.tsx` file, we are only getting our stream set up if the recordView state variable is true. Otherwise, nothing happens. This is by design. We want the user to be logged in through Farcaster before we open up the video capabilities.

Ok, let’s create the other functions we need. If you remember, there were functions in the `Header.tsx` file that were being pulled from a `farcaster.ts` file. Let’s create that file in our utils folder. Once it’s created, add this:

```Text farcaster.ts
import axios, { AxiosRequestConfig, AxiosResponse } from "axios";
import canonicalize from "canonicalize";

export type TokenPayload = {
  secret: string;
}

export type FC_Auth = {
  token: TokenPayload;
}

export const getAuthTokenFromFC = async (bearer: string, payload: string) => {
  const config: AxiosRequestConfig = {
    headers: {
      "Content-Type": "application/json"
    }
  }
  const res:AxiosResponse = await axios.post("/api/auth", {payload, bearer}, config)
  return res.data;
}

export const generateAuthToken = () => {
  const now = Date.now();

  const params = {
    method: "generateToken",
    params: {
        timestamp: now,
        expiresAt: now + 600000,
    },
  }

  const payload = canonicalize(params);
  if (payload === undefined)
      throw new Error("failed to canonicalize auth params");
  return payload;  
}

export const fetchProfile = async () => { 
  try {
    const auth: FC_Auth = JSON.parse(localStorage.getItem("fc-token") || "") 
    if(!auth) {
      throw "Not authenticated";
    }
  
    const res = await axios.get("/api/auth", {
      headers: {
        Authorization: auth.token.secret
      }
    });
  
    return res.data;
  } catch (error: any) {
    console.log(error);
    console.log(error.message);
    return null;
  } 
}

export const fetchFeed = async () => {
 try {
  const res = await axios.get("/api/feed")  
  return res.data
 } catch (error) {
  console.log(error);
  alert("Error fetching feed");
 }
}
```

We’re going to need to write some API routes for any of these functions to work, but we will walk through them one by one to understand their purpose.

The `getAuthTokenFromFC` function is used to take a signed message and turn in into a token that gives you access to speak with the Farcaster storage hub (currently there is just one Farcaster hub, but in the future, there will be many). To call this function, you need to create a signed bearer token. That is done by leveraging the `generateAuthToken` function. This function simply creates the message that will be signed by the wallet client side. If you take a look back at our `Header.tsx file`, you’ll see the `wagmi` hook called `useSignMessage`. This function will prompt a wallet signature based on the payload generated from the generateAuthToken function.

The `fetchProfile` function takes the token that is returned from Farcaster’s API and allows you to fetch the profile for the logged in user. Finally, the fetchFeed function will load up our feed of posts.

Ok, now let’s write our API routes. In your project root, you have the pages folder. Inside that folder is an api folder. Let’s start with the auth endpoint. Create a file called `auth.ts`. Inside that file, add the following:

```Text auth.ts
import axios from "axios";
import { MerkleAPIClient } from "@standard-crypto/farcaster-js";
import { NextApiRequest, NextApiResponse } from "next";


export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === "POST") {
    const data = req.body.payload;

    var config = {
      method: 'put',
      url: 'https://api.farcaster.xyz/v2/auth',
      headers: {
        'Accept': 'application/json, text/plain, */*',
        'Authorization': req.body.bearer,
        'Content-Type': 'application/json'
      },
      data: data
    };

    const response = await axios(config);
    res.json(response.data.result);
  } else if (req.method === "GET") {
    try {
      const apiClient = new MerkleAPIClient({
        secret: req.headers.authorization || ""
      });
      const user = await apiClient.fetchCurrentUser();

      return res.json(user);
    } catch (error: any) {
      console.log(error);
      if (MerkleAPIClient.isApiErrorResponse(error)) {
        const apiErrors = error.response.data.errors;
        for (const apiError of apiErrors) {
          console.log(`API Error: ${apiError.message}`);
        }
        console.log(`Status code: ${error.response.status}`);
        res.status(error.response.status).json(apiErrors)
      } else {
        res.status(500).send(error.message);
      }
    }
  } else {
    res.status(200);
  }
}
```

In this API route, we are using an SDK developed specifically for working with the Farcaster protcol. We are using a class from that SDK called `MerkleApiClient`. You’ll notice our `POST` request does not use that class. Instead, it takes the signed bearer token that we created client side and uses it as a bearer token in the request to generate an auth token from Farcaster. It’s a bit confusing, but think of this similar to the token exchange flow for many OAuth providers.

In our `GET` request, we are using the token that was generated in our `POST` request to build an API client for the Farcaster protocol using the `MerkleApiClient` class. Then, we use that API client and call the `fetchCurrentUser` function. We return the result, which includes the logged in user’s Farcaster profile info.

Let’s create our feed endpoint. But before we do, we should talk about different ways we can populate our feed. Since Farcaster’s protocol is open, we can fetch data from it directly, filter by posts that are for our new video app only, and then return that. This is very inefficient and would likely timeout most serverless functions. An alternative would be to run an indexer service on a dedicated server that constantly updates a database with the posts that are on the network. [There are indexers built by the Farcaster community](https://github.com/gskril/farcaster-indexer) that should make this easy, but we’re going to take an ever easier approach. We’re going to add metadata to each post we upload to Pinata, and we’re going to query for just those files and return that as our feed.

So, go ahead and create a file called `feed.ts` in your api folder. Then, add the following:

```javascript feed.ts
import axios from "axios";
import { NextApiRequest, NextApiResponse } from "next";
const pinataSDK = require("@pinata/sdk");
const pinata = new pinataSDK({ pinataJWTKey: process.env.PINATA_API_KEY });

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method === "POST") {
    //  No post requests here...
  } else if (req.method === "GET") {
    try {
      const metadata = {
        farcaster_video: {
          value: "true",
          op: "eq",
        },
      };
      const filters = {
        pageOffset: req.query.offset || 0,
        status: "pinned",
        metadata,
      };
      const feed = await pinata.pinList(filters);
      res.json(feed);
    } catch (error: any) {
      res.status(500).send(error.message);
    }
  } else {
    res.status(200);
  }
}

```

We’re going to be making use of the Pinata SDK for this API endpoint. You can read more about the SDK here. You’ll notice we are also finally using our Pinata API key JWT. In this case I am reading it from an env file. That’s the best way to protect your key. So if you don’t have one, create a `.env.local` file in the root of your project, then add this:

```Text .env.local
PINATA_API_KEY=YOUR PINATA JWT
```

Make sure that file is ignored by git by adding it to your `.gitignore` file like this:

```Text .gitignore
.env.local
```

Now, back to that API route. The `GET` request takes an optional offset query parameter. This is so that we can load more post. We are only going to load 10 posts as a time to keep things from being overwhelming, but you may want to add pagination or auto-loading logic to load more. To do so, you just need to append an offset. For example, if you have already loaded 20 files and you want the next 10, your offset would be `offset=20`.

To actually fetch the files, we are telling the Pinata SDK to filter by files that have a metadata property of `farcaster_video` and a value of `true`. This is our simple hack for creating our feed. But, again, you may want to consider running an indexer and a database.

Alright, we have one more API endpoint to create. The upload endpoint. No time like the present. Let’s build it! Create a file in your api folder called `upload.ts`. Then, add the following:

```javascript upload.ts
import type { NextApiRequest, NextApiResponse } from 'next'
import { MerkleAPIClient } from "@standard-crypto/farcaster-js";
import formidable from "formidable";
import fs from "fs";
import FormData from "form-data";
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK({ pinataJWTKey: process.env.PINATA_API_KEY });

export const config = {
  api: {
    bodyParser: false,
  }
};

const saveFile = async (file: any) => {
  try {
    const stream = fs.createReadStream(file.filepath);
    let data: any = new FormData();
    data.append('file', stream);
    const options = {
      pinataMetadata: {
          keyvalues: {
              farcaster_video: 'true'          
          }
      }     
    };
    const response = await pinata.pinFileToIPFS(stream, options);    

    fs.unlinkSync(file.filepath);

    return response.data;
  } catch (error) {
    throw error;
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<String>
) {
  if (req.method === "POST") {
    try {
      //  Check for logged in user
      const apiClient = new MerkleAPIClient({
        secret: req.headers.authorization || ""
      });
      const user = await apiClient.fetchCurrentUser();
      if(!user) {
        return res.status(401).send("Unauthorized");
      }
      const form = new formidable.IncomingForm();
      form.parse(req, async function (err, fields, files) {
        if (err) {
          console.log({ err })
          throw err;
        }
        const response = await saveFile(files.file);
        const { IpfsHash } = response;
        
        const text = `New video from @${user.username}\n View it https://gateway.pinata.cloud/ipfs/${response.hash}`

        await apiClient.publishCast(text)
        return res.status(200).send(IpfsHash)
      }); 
    } catch (error) {
      console.log(error);
      res.send("Server Error");
    }    
  } else if(req.method === "OPTIONS") {
    return res.status(200).send("ok");
  }
}
```

This endpoint will first check to see if we have an authenticated user (can’t let just anyone upload, right?). We will use the same method we used for fetching the user profile in our auth.ts file. Assuming the user is authorized, we can now parse the file and upload to Pinata. We are using the formidable library to help us pare the file upload. If you check the saveFile function, you’ll see we are taking the parsed file, creating a read stream, adding some metadata (remember, we need this metadata to query Pinata), and then uploading the file. When we’re done, we return the response and create a string that can be used in the cast which is what Farcaster calls posts. We publish that, then return the IPFS hash to the client.

We’re almost done! If you remember when we were working on our `Header.tsx` file, there were a few functions stubbed out. It’s time to fill those in. Back in the `Header.tsx` file, find the handleRecord function, and update it to look like this:

```javascript Header.tsx
const handleRecord = async () => {
    if (recording === true) {
      setRecording(false)
      mediaRecorder.stop()
      setTime(7)
    } else {
      setRecording(true)
      const media = new MediaRecorder(strm, { mimeType: mimeType })
      setMediaRecorder(media)
      let blobs_recorded: any = []

      media.addEventListener('dataavailable', function (e) {
        blobs_recorded.push(e.data)
      })

      media.addEventListener('stop', async function () {
        const blob = new Blob(blobs_recorded, { type: 'video/mp4' })

        setBlob(blob)
        let video_local = URL.createObjectURL(blob)
        const previewVideo: any = document.getElementById('preview')
        previewVideo.src = video_local
        setPreviewUrl(video_local)
        setRecording(false)
        setTime(7)
        strm.getTracks().forEach((track: any) => {
          track.stop()
          track.enabled = false
        })
        const audioContext = new AudioContext()
        audioContext.close
        const microphone = audioContext.createMediaStreamSource(strm)
        microphone.disconnect
      })

      media.start()

      setTimeout(() => {
        if (media.state === 'recording') {
          media.stop()
        }
      }, 7000)
    }
  }
```

There’s a lot going on here. Enough, honestly for a whole other tutorial. So, just trust me when I say we’re using the `MediaRecorder` API to create a recorded stream from our video feed and turning it into a file that we can use to store on IPFS. I would highly encourage you to read more about the `MediaRecorder` API here, though.

So this function is setting a state variable indicating that recording has started. It is counting down our six-second timer. When the timer is up, the recorder is stopped and we create a video file that can be previewed. Remember, we had two video elements? We’ll use the second one to show the preview video. We should display the time instead of the record button after `record` is pressed. So up towards the top of your file, after the first `useEffect` hook you created, add another one that looks like this:

```javascript
  useEffect(() => {
    if (time && recording) {
      setTimeout(() => {
        setTime(time - 1)
      }, 1000)
    }
  }, [time, recording])
```

This is simply responding to a change in either the `recording` or `time` state variables and setting a timeout function to reduce the time by one second. Now, find your `record` button in the code and replace it with this:

```javascript
 <div>
  {recording ? <span>{time.toString()}</span> : <button onClick={handleRecord}>Record</button>}
 </div>
```

Try it out, you should see something like this:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d5a690b-1_SH5PTCKwVGGYlfMdUbzNpQ.gif",
        "",
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


This thing is coming along. It’s ugly, but it’s functional. You can make it pretty, right?

Now, we need to connect the upload functionality. That was another function we had stubbed out. Let’s work on fixing that. In your `Header.tsx` file, find the `handleUpload` function. Add the following to that function:

```Text Header.tsx
const handleUpload = async () => {
    if (!previewUrl) {
      alert('Must have a video')
      return
    }
    setPosting(true)

    const FID = user.fid
    const form:any = new FormData()
    form.append(
      'video',
      blobData,
      `${FID}-${Date.now()}.${mimeType.split('/')[1]}`
    )

    try {
      const res:AxiosResponse = await axios.post('/api/upload', form, {
        maxBodyLength: Infinity,
        headers: {
          'Content-Type': `multipart/form-data; boundary=${form._boundary}`,
          Authorization: JSON.parse(localStorage.getItem('fc-token') || "").token
            .secret,
        },
      })
      console.log('upload: ', res.data)
      setPosting(false)
      cancel()
      setRecordView(false)
      loadPosts()
    } catch (error:any) {
      console.log(error)
      setPosting(false)
      alert(error.message)
    }
  }
```

This function is taking the `blobData` from our video stream recording and creating a file upload to our `upload` endpoint. We are grabbing our Farcaster auth token from local storage and passing that through to the server so that we can create our `cast`. When the file is uploaded, we load the posts and close the recording modal.

One last thing we can do before connecting our `loadPosts` function is to show some sort of uploading indicator. Find the Post Video and Cancel buttons in the `Header.tsx` file and replace them with this:

```javascript
{
  posting ? (
    <div>Uploading...</div>
  ) : (
    <div>
      <button className="mr-2" onClick={handleUpload}>
        Post Video
      </button>
      <button className="ml-2" onClick={cancel}>
        Cancel
      </button>
    </div>
  );
}
```

Ok, we’ve let the user know the video is uploading. Now, we need to connect our `loadPosts` function. If you remember, that function was in the `index.tsx` file. Head back over there, and we’ll update the entire file with out changes:

```javascript index.tsx
import Feed from '../components/Feed'
import Header from '../components/Header'
import axios from "axios";
import { useState, useEffect } from 'react';
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK({ pinataJWTKey: process.env.PINATA_API_KEY });

export default function Home(props: any) {  
  const [posts, setPosts] = useState<any>(props.data);
 
  const loadPosts = async () => {
    try {
      const res = await axios.get("/api/feed");
      const data = res.data;
      setPosts(data.rows); 
    } catch (error) {
      alert("Trouble loading posts");
    }
  }
  return (
    <div className="w-full">
      <Header loadPosts={loadPosts} />
      <Feed posts={posts} />
    </div>
  )
}

export async function getStaticProps() {
  const metadata = {
    keyvalues: {
      farcaster_video: {
        value: "true", 
        op: "eq"
      }
    }        
  }
  const filters = {
    pageOffset: 0,
    status: "pinned",
    metadata
  }
  const feed = await pinata.pinList(filters);  

  return {
    props: {
      data: feed.rows
    },
    revalidate: 10,
  }
}
```

We’re using `Axios` to make our request in the `loadPosts` function. We are also using the `useState` hook to store our posts response. We pass the posts state variable to our `Feed.tsx` component. Notice, though, at the bottom of this component, we are using `getStaticProps`. This allows us to make server-side requests (without exposing environment variables to the client) ahead of the page loading. The beauty of this is the page loads with all the data ready to go on first load.

And now, I think we’re ready to finally wire up the Feed.

Inside your `Feed.tsx` file, replace everything with:

```java Feed.tsx
import React from "react";

type props = {
  posts: any[],
};

const Feed = (props: props) => {
  const { posts } = props;

  return (
    <div className="mt-20">
      {posts.map((p) => {
        return (
          <div key={p.ipfs_pin_hash}>
            <video
              src={`https://gateway.pinata.cloud/ipfs/${p.ipfs_pin_hash}`}
              playsInline
              autoPlay
              muted
              controls
              loop
              id={p.cid}
            ></video>
          </div>
        );
      })}
    </div>
  );
};

export default Feed;

```

We are looping over the posts and rendering them as videos using a simple video element. You’ll notice we’re using Pinata’s public IPFS gateway. This will likely not work well since it’s rate limited, but it’s fine to test with. If you want a flawless experience, consider upgrading to a paid plan and using a dedicated IPFS gateway.

And with that, we have a fully functional basic Vine close. 6-second videos stored on IPFS, posted to the open social protocol Farcaster and rendered in stunning quality in our simple app. Maybe not stunning quality, but I believe in you. I think you can make it stunning.

Things you can do to improve this app:

Add lazy loading to load more posts using the offset filter  
Improve the UI  
Handle multiple devices and browsers (Chrome records in webm, Safari in mp4)  
Add a Pinata Dedicated Gateway and include streaming functionality  
And so much more  
If you’d like to see the full source code, you can find it here. If you’d like to see a much more engineered and polished version of this app in the wild, check out Absorb, Pinata’s sample implementation built as a proof of concept.

Absorb - 7-second videos because what's one extra second  
Absorb - 7-second videos because what's one extra second  
Absorb - 7-second videos because what's one extra secondgetabsorb.com

As always, enjoy the tutorial and keep on building!
