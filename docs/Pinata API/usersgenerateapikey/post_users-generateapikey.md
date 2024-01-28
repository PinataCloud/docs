---
title: "Generate Pinata API Key"
slug: "post_users-generateapikey"
excerpt: "Create a Pinata API key"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Tue Jul 18 2023 00:34:01 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Thu Sep 21 2023 00:49:07 GMT+0000 (Coordinated Universal Time)"
---
This endpoint is used to programmatically generate Pinata API keys. This endpoint can only be called by using an "Admin" key. When generating new keys, specific scopes and limits can be implemented. 

This endpoint will return three values: The API Key, the API Secret, and a JWT Bearer Token. For more information on these values, [see the authentication section](../introduction-to-the-pinata-api/authentication.md).

**Make sure to record the API Secret and the JWT as they will not be accessible again.**

## Generating an API Key

The request body when generating a Pinata API key will look like this: 

```
{
    keyName: (A name for your new key for easy reference - Required),
    maxUses: (Number of times the new api keys can be used - Optional),
    permissions: {
      admin: boolean,
      endpoints: {
        data: {
          pinList: boolean,
          userPinnedDataTotal: boolean
        },
        pinning: {
          hashMetadata: boolean,
          hashPinPolicy: boolean,
          pinByHash: boolean,
          pinFileToIPFS: boolean,
          pinJSONToIPFS: boolean,
          pinJobs: boolean,
          unpin: boolean,
          userPinPolicy: boolean
        }
      }
    }
}
```

Notice the `keyName` is required. When setting the permissions, it is necessary to include all properties and sub-properties unless you are creating an admin key. If you are creating an admin key, the `endpoints` property and sub-properties can be omitted. If you are including the `endpoints` property, you cannot include the `admin` property. 

For example, this would be a simplified body for admin key generation: 

```
{
    keyName: "My admin key",
    permissions: {
      admin: true
    }
}
```
