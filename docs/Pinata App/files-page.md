---
title: "Files"
slug: "files-page"
excerpt: "https://app.pinata.cloud/pinmanager"
hidden: false
createdAt: "Fri Jul 28 2023 18:39:58 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Tue Nov 21 2023 19:46:49 GMT+0000 (Coordinated Universal Time)"
---
The files page is center of the Pinata App where you can upload files, manage them, and view them through a [Dedicated Gateway](doc:dedicated-ipfs-gateways).

## Add Files

Uploading files is simple, just click on the "Add Files" button in the top right, select if its a folder or a file you want to upload, select the content, give it a name, then upload! 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/d4e967e-Upload_File.gif",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


When you upload a file this way, Pinata automatically pins the content to IPFS. After pinning to IPFS you will see a CID that is used to access the content across the IPFS network, and the CID is typically used in mediums such as NFTs. [Read more about NFTs here](doc:ipfs-and-nfts)or how [how IPFS works here](doc:what-is-ipfs).

![](https://files.readme.io/026002e-Screenshot-Arc-07-28-2023-16-122x.png)

> 🚧 Files uploaded to Pinata are Pinned to IPFS and can be publicly accessed!

### Pin by CID

Another option for uploading files is pinning something that is already on IPFS. This can be content from another IPFS pinning service or from your own local IPFS node. 

To pin content this way, click on the "Add Files" button in the top right, select "CID," then paste in the CID and the name you want to use, then click "Search and Pin." After doing this it will be added to a queue where Pinata will start looking for the content.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c16cd9d-pinbycid.gif",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


While in the Pin By CID queue there are several possible statuses:

| Status        | Description                                                                                                                                                                                                                                             |
| :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Prechecking   | Pinata is prechecking the CID before searching, making sure it's a valid CID. e.g. if you put in random words instead of a valid CID it would fail the prechecking                                                                                      |
| Searching     | Pinata is currently looking for the CID content on IPFS. If your pin job is stuck in the searching status, that usually means we can't find the CID and the file is not available on IPFS.                                                              |
| Retrieving    | Pinata has found the CID and is currently pinning the content to Pinata IPFS nodes. Be aware that the speed might vary on the number of files and the IPFS network. Pinning by CID can take anywhere from a few minutes to a whole day.                 |
| Expired       | Pinata was in the middle of retrieving the files, but there was an interruption in the connection.                                                                                                                                                      |
| over_max_size | Pinata identified the file/folder as being over the 25GB upload limit. The Pinata team can help with special cases that go over this limit, but we cannot guarantee success. Please email [team@pinata.cloud](mailto:team@pinata.cloud) for assistance. |

If you are trying to upload through a local IPFS node we would recommend using [this guide](https://knowledge.pinata.cloud/en/articles/5509412-how-to-upload-a-large-folder-by-running-a-local-ipfs-node). 

### Upload Limits

Keep in mind that Pinata has a **25GB limit on individual files or folders** when uploading through the Pinata App. For more info please visit the [Limits Page](doc:limits).

## Viewing Files

To view your file, you can click on the "eye" icon which will either open the file through your [Dedicated Gateway](doc:dedicated-ipfs-gateways). 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/47815de-Preview_File.gif",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


## Deleting Files

> 🚧 Deleting files from Pinata only unpins them from Pinata's IPFS nodes. If the file is pinned elsewhere or with another service, it will remain on IPFS.

If you want to delete any files you have uploaded, you can click on the "More" button and select "Delete File."

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/8c11eec-Screenshot-Arc-07-28-2023-16-18.gif",
        null,
        ""
      ],
      "align": "center"
    }
  ]
}
[/block]


> 📘 We are currently working on a bulk-unpin feature in the Pinata App. In the meantime you can use [this script](https://gist.github.com/stevedylandev/8f436ac7db9db8b36d9f54d2cf24dac6) to unpin a large selection of files.
