---
title: "Optimising Package Distribution"
date: 2021-03-02T19:03:11+11:00
draft: false
type: "post"
authors: [sunnyflunk]
categories: [news]
featuredImage: "/img/blog/optimising-package-distribution/Featured.png"
---

Getting updates as fast as possible to users has made deltas a popular and sought after feature for distributing
packages. Over the last couple of days, I've been investigating various techniques we can look at to support deltas in
`moss`.

<!--more-->

#### Trade-offs Between Packages and Deltas

Minimising the size of updates is particularly valuable where files are downloaded many times and even better if they're
updated infrequently. With a rolling release, packages will be updated frequently, so creating deltas can become
resource intensive, especially if supporting updates over a longer period of time. Therefore it's important to get the
right balance between compression speed, decompression memory and minimising file size.

{{<table>}}

|              | Package priorities           | How best to meet these needs |
|--------------|------------------------------|------------------------------|
| Developers   | Creation speed               | Quickly created packages     |
| Users        | File size and update speed   | Size minimised deltas        |

From the users point of view, minimising file size and upgrade time are important priorities, but for a developer, the
speed at which packages are created and indexed is vital to progression. Deltas are different to packages in that they
aren't required immediately, so there's minimal impact in taking longer to minimise their size. By getting deltas right,
we can trade-off the size of packages to speed up development, while users will not be affected and fetch only size
optimised deltas.

#### Test Case - QtWebEngine

QtWebEngine provides a reasonable test case where the package is a mix of binaries, resources and translations, but
above average in size (157.3MB uncompressed). The first trade-off for speed over size has already been made by
incorporating `zstd` in moss over `xz`, where even with max compression `zstd` is already 5.6% larger than using `xz`.
This is of course due to the amazing decompression speeds where `zstd` is magnitudes faster.

{{<figure_screenshot_one image="optimising-package-distribution/Featured" caption="Compression levels with zstd">}}

With maximum compression, large packages can take over a minute to compress. With a moderate increase in size, one can
reduce compression time by 2-10x. While making me happier as a developer, it does create extra network load during
updates.

| Full Package    | zstd -16 -T0 | zstd -16 | zstd -19 -T0 | zstd -19 | zstd -22 | xz -9  |
|-----------------|--------------|----------|--------------|----------|----------|--------|
| Time to create  | 5.4s         | 26.8s    | 27.8s        | 56.0s    | 70.6s    | 66.5s  |
| Size of package | 52.6MB       | 52.6MB   | 49.2MB       | 49.2MB   | 48.4MB   | 45.9MB |

#### Deltas to the Rescue!

There are two basic methods for deltas. One simple method is to include only files that have been changed since the
earlier release. With reproducible builds, it is typical to create the same file from the same inputs. However, with a
rolling release model, files will frequently have a small change from dependency changes and new versions of the package
itself. In these circumstances the delta size starts to get closer to the full package anyway. As a comparison to other
delta techniques, this approach resulted in a 38.2MB delta as it was a rebuild of the same version at a different time
so the resources and translations were unchanged (and therefore omitted from the delta).

An alternative is a binary diff, which is a significant improvement when files have small changes between releases.
`bsdiff` has long been used for this purpose and trying it out (without knowing much about it) I managed to create a
delta of 33.2MB, not a bad start at all.

To highlight the weakness of the simple method, when you compare the delta across a version change, the simple delta was
only a 7% reduction of the full package (as most files have changed), while using an optimal binary diff, it still
managed to achieve a respectable 31% size reduction.

#### A New Contender

While looking into alternatives, I happened to [stumble across](https://github.com/facebook/zstd/releases/tag/v1.4.5)
a new feature in `zstd` which can be used to create deltas. As we already use `zstd` heavily it should make integration
easier. `--patch-from` allows `zstd` to use the old uncompressed package as a dictionary to create the newer package. In
this way common parts between the releases will be reused in order to reduce the file size. Playing around I quickly
achieved the same size as `bsdiff`, and with a few tweaks was able to further reduce the delta by a **further 23.5%!**
The best part is that it has the same speedy decompression as `zstd`, so it will recreate most packages from deltas in
the blink of an eye!

| Delta           | only changed files | bsdiff | zstd -19 | zstd -22 | zstd -22 --zstd=chainLog=30 |
|-----------------|--------------------|--------|----------|----------|-----------------------------|
| Time to create  | 60.8s              | 153.0s | 85.5s    | 111.6s   | 131.8s                      |
| Size of delta   | 38.2MB             | 33.2MB | 33.3MB   | 28.5MB   | 25.4MB                      |


#### Next Steps

There's certainly a lot of information to digest, but the next step is to integrate a robust delta solution into the
`moss` format. I really like the `zstd` approach, where you can tune for speed with an increase in size if desired. With
minimising on delta size, users can benefit from smaller updates while developers can benefit from faster package
creation times.

Some final thoughts for future consideration:

- `zstd` has seen many improvements over the years, so I believe that ratios and performance will see incremental
improvements over time. Release [1.4.7](https://github.com/facebook/zstd/releases/tag/v1.4.7) already brought
significant improvements to deltas (which are reflected in this testing).
- The highest compression levels (`--ultra`) are single threaded in `zstd`, so delta creation can be done in parallel to
maximise utilisation.
- Over optimising the tunables can have a negative impact on both speed and size. As an example,
`--zstd=targetLength=4096` did result in a 2KB reduction in size at the same speed, but when applied to different inputs
(kernel source tree), it not only made it larger by a few hundred bytes, but added **4 minutes** to delta creation!
- Memory usage of applying deltas can be high for large packages (1.74GB for the kernel source tree) as it has to ingest
the full size of the original uncompressed package. It is certainly possible to split up payloads with some delta users
even creating patches on a per file basis. It is a bit more complicated when library names change version numbers each
release with only the SONAME symlink remaining unchanged.
- There's always the option to repack packages at higher compression levels later (when deltas are created). This solves
getting the package 'live' ASAP and minimises the size (eventually), but adds some complication.
