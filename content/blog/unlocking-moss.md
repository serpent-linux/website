---
title: "Unlocking Moss"
date: 2021-02-09T12:45:34Z
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/unlocking-moss/Featured.png"
---

Wait, what? Another blog post? In the same WEEK? Yeah totally doing that
now. So, this is just another devlog update but there have been some interesting
updates that we'd like to share.

<!--more-->


#### LDC present in the bootstrap

Thanks to some awesome work from Peter, we now have LDC (The LLVM D Lang Compiler)
present in the stage3 bootstrap. To simplify the process we use the official
binary release of LDC to bootstrap LDC for Serpent OS.

In turn, this has allowed us to get to a point where we can now build `moss` and
`boulder` within stage3. This is super important, as we'll use the stage3 chroot
and `boulder` to produce the binary packages that create stage4.

Some patching has taken place to prevent using `ld.gold` and instead use `lld`
to integrate with our toolchain decisions.

{{<figure_screenshot_one image="unlocking-moss/Featured" caption="A wild LDC appears">}}

#### Reworking the Payload implementation

Originally our prototype moss format only contained a `ContentPayload` for files, and
a `MetaPayload` for metadata, package information, etc. As a result, we opted for simple
structs, basic case handling and an iterable `Reader` implementation.

As the format expanded, we bolted deduplication in as a core feature. To achieve this,
we converted the `ContentPayload` into a "megablob", i.e. every **unique** file in the
package, one after the other, all compressed in one operation. We then store the offsets
and IDs of these files within an `IndexPayload` to allow splitting the "megablob" into
separate, unique assets. Consequently, we added a `LayoutPayload` which describes the
final file system layout of the package, referencing the unique ID (hash) of the asset
to install.

So, while the format grew into something we liked, the code supporting it became very
limiting. After many internal debates and discussions, we're going to approach the
format from a different angle on the code front.

It will no longer be necessary/possible to iterate payloads in _sequence_ within a
moss archive, instead we'll preload the data (unparsed) and stick it aside when reading
the file, winding it to the `ContentPayload` segment if found. After initial loading of
the file is complete, the `Reader` API will support retrieval (and lazy unpacking ) of
a data segment. In turn this will allow code to "grab" the content, index and layout
payloads and use advanced APIs to cache assets, and apply them to disk in a single
blit operation.

In short, we've unlocked the path to installing moss packages while preserving the
advanced features of the format. The same new APIs will permit introspection of the
archives metadata, and of course, storing these records in a stateful system database.

#### Thank you for the unnecessary update

Oh you're quite welcome :P Hopefully now you can see our plan, and that we're track
to meet our not-28th target. Sure, some code needs throwing away, but all codebases
are evolutionary. Our major hurdle has been solved (mentally) - now it's just time
to implement it and let the good times roll.
