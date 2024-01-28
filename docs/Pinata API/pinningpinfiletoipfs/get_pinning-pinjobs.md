---
title: "List Pin By CID Jobs"
slug: "get_pinning-pinjobs"
excerpt: "List all currently running pinByHash jobs"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 07 2023 19:48:25 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Thu Sep 21 2023 00:49:07 GMT+0000 (Coordinated Universal Time)"
---
When using the `pinByHash` endpoint, you may want to programmatically check on the status of CIDs you'd requested to be pinned to your account. This endpoint allows you to do so. 

## Listing Pin By CID Jobs

All possible filters are included in the API reference below, but these are the possible "status" filters:

- "status" - Filter by the status of the job in the pinning queue (see potential statuses below)
  - "prechecking" - Pinata is running preliminary validations on your pin request.
  - "searching" - Pinata is actively searching for your content on the IPFS network. This may take some time if your content is isolated.
  - "retrieving" - Pinata has located your content and is now in the process of retrieving it.
  - "expired" - Pinata wasn't able to find your content after a day of searching the IPFS network. Please make sure your content is hosted on the IPFS network before trying to pin again.
  - "over\_free\_limit" - Pinning this object would put you over the free tier limit. Please add a credit card to continue pinning content.
  - "over\_max\_size" - This object is too large of an item to pin. If you're seeing this, please contact us for a more custom solution.
  - "invalid\_object" - The object you're attempting to pin isn't readable by IPFS nodes. Please contact us if you receive this, as we'd like to better understand what you're attempting to pin.
  - "bad\_host\_node" - You provided a host node that was either invalid or unreachable. Please make sure all provided host nodes are online and reachable.
