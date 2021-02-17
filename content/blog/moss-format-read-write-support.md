---
title: "Moss Format: Read Write Support"
date: 2021-02-17T22:35:11Z
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/moss-format-read-write-support/Featured.png"
---

It's been 8 days since our last blogpost and a lot of development work has happened
in that time. Specifically, we've completely reworked the internals of the `moss-format`
module to support read/write operations.. Which means installation is coming soon (TM)

<!--more-->

{{<figure_screenshot_one image="moss-format-read-write-support/Featured" caption="Development work on moss-format">}}

So, many commits have been made to the core repositories, however the most
important project to focus on right now is `moss-format`, which we used to
define and implement our binary and source formats. This module is shared
between `boulder`, our build tool, and `moss`, our package manager.

We've removed the old enumeration approach from the `Reader` class, instead
requiring that it processes **data** payloads in-place, deferring reading the
**content** payload streams. We've also enforced strong typing to allow
safe and powerful APIs:

```d
        import moss.format.binary.payload.meta : MetaPayload;

        auto reader = new Reader(File(argv[0], "rb"));
        auto metadata = reader.payload!MetaPayload();
```
#

Right now we can read and write our `MetaPayload` from and to the stream,
allowing us to encode & decode the metadata associated with the package,
with strong type information (i.e. `Uint64`, `String`, etc.)

#### Next Steps

We need to restore the `IndexPayload`, `LayoutPayload` and `ContentPayload`
definitions. The first two are simply **data** payloads and will largely
follow the design of the newly reimplemented `MetaPayload`. Then we restore
`ContentPayload` support, and this will allow the next steps: unpack, install.

Many of the babysteps required are done now, which power our binary format.
The design of the API is done in a way which will allow powerful manipulation
via the `std.algorithm` and `std.range` APIs, enabling extremely simple and
reliable installation routines.

It might seem odd that we've spent so much time on the core **format**,
however I should point out that the design of the format is central to the
OS design. Our installation routine is **not** unpacking of an archive.

With our binary format, the stream contains multiple PayloadHeaders,
with fixed lengths, type, tag, version, and compression information.
It is up to each Payload implementation to then parse the binary
data contained within. Currently our Payloads are compressed using ZSTD, though
other compression algorithms are supported.

So, we have the `MetaPayload` for metadata. Additionally, we encode all **unique**
files in the package in a single compressed payload, the `ContentPayload`. The
offset to each unique file (by hash) is stored within the `IndexPayload`, and
the filesystem layout is encoded as data within the `LayoutPayload`.

In order to unpack a moss package, the `ContentPayload` blob will be decompressed
to a temporary location. Then, each struct within the `IndexPayload` can be used
to copy portions (`copy_file_range`) of the blob to the cache store for permanence. We skip each Index
if its already present within the cache. Finally, the target filesystem is populated
with a view of all installed packages using the `LayoutPayload` structs, creating
a shallow installation using hardlinks and directories.

The net result is deep deduplication, atomic updates, and flexibility for the user.
Once we add transactions it'll be possible to boot an older version of the OS using
the deduplication capabilities for offline recovery. Additionally there is no requirement
for file deletion, rename or modification for an update to succeed.

#### Nutshell

Huge progress. Major excitement. Such wow. Soon alphas.
