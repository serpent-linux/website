---
title: "Moss Format Defined"
date: 2020-09-20T13:48:50+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/moss-format-defined/Featured.png"
---

The core team have been hard at work lately implementing the [Moss package manager](https://github.com/serpent-linux/moss).
We now have an initial version of the binary format that we're happy with, so we thought we'd share a progress update
with you.

{{<figure_screenshot_one image="moss-format-defined/Featured" caption="Development work on Moss">}}

#### Explaining the format

Briefly, the binary container format consists of 4 payloads:

 - Meta (Information on the package)
 - Content (a binary blob containing all files)
 - Index (indices to files within the binary blob)
 - Layout (How to apply the files to disk)

Each payload is verified internally using a CRC64-ISO, and contains basic information such as the length of the payload
both compressed and uncompressed, the compression algorithm used (`zstd` and `zlib` supported) as well as the type and
version of the payload. All multiple-byte values are stored in Big Endian order (i.e. Network Byte Order).

{{<figure_screenshot_one image="moss-format-defined/Payloads" caption="All relevant payloads">}}

Internally the representation of a Payload is defined as a 32-byte struct:

```d
    @autoEndian uint64_t length = 0; /* 8 bytes */
    @autoEndian uint64_t size = 0; /* 8 bytes */
    ubyte[8] crc64 = 0; /* CRC64-ISO */
    @autoEndian uint32_t numRecords = 0; /* 4 bytes */
    @autoEndian uint16_t payloadVersion = 0; /* 2 bytes  */
    PayloadType type = PayloadType.Unknown; /* 1 byte  */
    PayloadCompression compression = PayloadCompression.Unknown; /* 1 byte */
```

We merge all unique files in a package rootfs into the `Content` payload, and compress that using zstd. The offsets to
each unique file (i.e. the sha256sum) are stored within the `Index` payload, allowing us to extract relevant portions
from the "megablob" using `copy_file_range()`.

These files will become part of the system hash store, allowing another level of deduplication between all system
packages. Finally, we use the `Layout` payload to **apply** the layout of the package into a transactional rootfs.
This will define paths, such as `/usr/bin/nano`, along with permissions, types, etc. All regular files will actually
be created as hard links from the hash store, allowing deduplication and snapshots.

The `Meta` payload consists of a number of records, each with strongly defined types (such as `String` or `Int64`) along
with the tag, i.e. `Name` or `Summary`. The entire format is binary to ensure greater resilience and a more compact
representation. For example, each metadata key is only 8 bytes.

```d
    @autoEndian uint32_t length; /** 4 bytes per record length*/
    @autoEndian RecordTag tag; /** 2 bytes for the tag */
    RecordType type; /** 1 byte for the type */
    ubyte[1] padding = 0;
```


#### TLDR that for me...

Binary format that is self deduplicating at several layers, permitting fast transactional operations.

#### Up Next

Before we work any more on the binary format, we now need to pivot to the source format. Our immediate goal is to now
have moss actually **build** packages from source, with resulting `.stone` packages. Once this step is complete we can
work on installation, upgrades, repositories, etc, and race to becoming a self hosting distribution.

Note, the format may still change before it goes into production, as we encounter more cases for optimisation or
improvement.
