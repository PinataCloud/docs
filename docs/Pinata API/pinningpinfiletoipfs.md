---
title: "Pinning"
slug: "pinningpinfiletoipfs"
excerpt: "The essentials of uploading files to Pinata to be pinned to IPFS"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 07 2023 19:48:22 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Thu Sep 21 2023 00:49:34 GMT+0000 (Coordinated Universal Time)"
---
The Pinning endpoints are for all operations involving files pinned to IPFS through Pinata. These endpoints should generally be used from a server environment to ensure your API keys are protected. 

For all operations that result in a file being uploaded or added to an account, there are optional pieces of data that can be included. 

## Pinata Options

`pinataOptions`

Pinata supports adding additional options when pinning a file. The following options are currently supported for this endpoint:

- cidVersion - The CID Version IPFS will use when creating a hash for your content. Valid options are: "0" (CIDv0) or "1" (CIDv1)
- wrapWithDirectory - Wrap your content inside of a directory when adding to IPFS. This allows users to retrieve content via a filename instead of just a hash. For a more detailed explanation, see [this informative blogpost](https://flyingzumwalt.gitbooks.io/decentralized-web-primer/content/files-on-ipfs/lessons/wrap-directories-around-content.html). Valid options are: true or false

Here is an example of the object to create `pinataOptions`:

```Text JSON
pinataOptions: {
    cidVersion: 0, 
    wrapWithDirectory: false
}
```

## Pinata Metadata

`pinataMetadata`

In addition to pinning your file to Pinata, you also have the option to include metadata for Pinata to store.

This metadata can later be used for easy querying on what you've pinned with our [userPinList](broken-reference) request.

The optional metadata object takes the following form:

```Text JSON
{
    name: "A custom name. If you don't provide this value, it will automatically be populated by the original name of the file you've uploaded",
    keyvalues: {
        customKey: "customValue",
        customKey2: "customValue2"
    }
}
```

The key values object allows for users to provide any custom key / value pairs they want for the file being uploaded. These values can be:

- Strings
- Numbers (integers or decimals)
- Dates (Provided in ISO\_8601 format)

As of right now, this is limited to 10 key/value pairs, but if this is a problem for you, please let us know!

**A Real World JSON Example**

As an example, let's pretend you're building a service for lawyers and want to tag every IPFS upload with the Lawyer's ID, the ID for the Lawyer's client, a charge code, and the cost of the service being provided.

Your `pinataMetadata` object may look like this:

```json
{
    name: 'ExampleNameOfDocument.pdf'
    keyvalues: {
        LawyerName: 'Lawyer001',
        ClientID: 'Client002',
        ChargeCode: 'Charge003'
        Cost: 100.00
    }
}
```
