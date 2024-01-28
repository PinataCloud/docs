---
title: "List Files"
slug: "get_data-pinlist"
excerpt: "List all the files on your Pinata account"
hidden: false
metadata: 
  image: []
  robots: "index"
createdAt: "Fri Jul 07 2023 19:48:25 GMT+0000 (Coordinated Universal Time)"
updatedAt: "Sat Sep 23 2023 21:50:17 GMT+0000 (Coordinated Universal Time)"
---
This endpoint returns data on what content the sender has pinned to IPFS through Pinata.  
The purpose of this endpoint is to provide insight into what is being pinned, and how long it has been pinned.  
The results of this call can be filtered using multiple query parameters that will be discussed below.

## Metadata Querying

You also have the option to query your content on the associated metadata that may have been included with the content when it was uploaded through either the PinFileToIPFS or PinJSONToIPFS endpoints.

These queries look very similar to the default parameters but are slightly more complex.

Here are few simple examples, with added explanation afterward.

To query on the name you provided for your pin, your query would take this form:

`?metadata[name]=exampleName`

(this will match on names that contain the string of characters provided as a value. For added specificity, please include the full name you're trying to find).

To query on the metadata key-value attributes:

`?metadata[keyvalues]={"exampleKey":{"value":"exampleValue","op":"exampleOp"}}`

Or:

`?metadata[keyvalues][exampleKey]={"value":"exampleValue","op":"exampleOp"}`

To query on both the metadata name and multiple key-value attributes:

`?metadata[name]=exampleName&metadata[keyvalues]={"exampleKey":{"value":"exampleValue","op":"exampleOp"},"exampleKey2":{"value":"exampleValue2","op":"exampleOp2"}}`

Explaining the "value" and "op" key / values

As seen above, each query on custom values takes the form of an object with a "value" key and an "op" key.

The "value" is fairly straightforward. This is simply the value that you wish your query operation to be applied to. These values can be:

Strings  
Numbers (integers or decimals)  
Dates (Provided in ISO_8601 format)  
The "op" is what query operation will be applied to the value you provided. The following opcodes are available to query with:

"gt" - (greater than)  
"gte" - (greater than or equal)  
"lt" - (less than)  
"lte" - (less than or equal)  
"ne" - (not equal to)  
"eq" - (equal to)  
"between" - (When querying with the 'between' operation, you need to supply a 'secondValue' to be consumed by the query operation)  
For Example:

`?metadata[keyvalues]={"exampleKey":{"value":"2018-01-01 00:00:00.000+00","secondValue":"2018-02-01 00:00:00.000+00","op":"between"}}`

"notBetween" - (When querying with the 'notBetween' operation, you need to supply a 'secondValue' to be consumed by the query operation)  
For Example:

`?metadata[keyvalues]={"exampleKey":{"value":4.00,"secondValue":5.50,"op":"notBetween"}}`

"like" - (you can use this to find values that are similar to what you've passed in)  
For example, this query would find all entries that begin with "testValue". A % before your value means anything can come before it, and a % sign after means any characters can come after it. So %testValue% would contain all entries containing the characters "testValue".

`?metadata[keyvalues]={"exampleKey":{"value":"testValue%","op":"like"}}`

"notLike" - (you can use this to find values that do not contain the character string you've passed in)  
"iLike" - (The case insensitive version of the "like" opcode)  
"notILike" - (The case insensitive version of the "notLike" opcode)  
"regexp" - (Regular expression matching)  
"iRegexp" - (Case insensitive regular expression matching)
