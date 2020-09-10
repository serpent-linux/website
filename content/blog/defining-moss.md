---
title: "Defining Moss"
date: 2020-09-10T16:02:48+01:00
draft: false
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/defining-moss/Featured.png"
---

Over the past few weeks, throughout the entire bootstrap process, we've
been deliberating on what our package manager is going to look like. We
now have a very solid idea on what that'll be, so it's time for a blog
post to share with the community.

{{<figure_screenshot_one image="defining-moss/Featured" caption="Initial moss prototype CLI">}}

#### Old, but new

The team has been very clear in wanting a traditional package management solution,
whereby repositories and packages compose the OS as a whole. However, we also
want modern features, such as being stateless by default. A common theme
is wanting to reduce the complex iterations of an OS into something that
is sanely versioned, but also flexible, to ensure a consistent, tested
experience with multiple end targets.

Additionally, the OS must be incredibly easy for contributors and team members
to maintain, with intelligent tooling and simple, but powerful formats.

#### Atomic updates

One of the most recent software update trends of recent years is atomic updates.
In essence this allows applying an update in a single operation, and importantly,
reversing an update in a single operation, without impacting the running system.

This is typically achieved using a so-called `A/B switch`, which is what we will
also do with moss. We won't rely on any specific filesystem for this implementation,
instead relying on a smart layout, `pivot_root` and a few other tricks.

Primarily we'll update a single `/usr` symlink to point to the current OS image,
with `/` being a read-only faux rootfs, populated with established mountpoints
and symlinks. Mutation will be possible only via `moss` transactions, or in
world-writable locations (`/opt`, `/usr/local`, `/etc` ...)

#### Deduplication

The moss binary package format will be deduplicated in nature, containing hash-keyed
blobs in an `zstd` compressed payload. Unique blobs will be stored in a global cache,
and hard-linked into their final location (i.e. `/moss/root/$number/usr/...`) to
deduplicate the installed system too. This allows multiple system snapshots with
minimal overhead, and the ability to perform an offline rollback.

#### Implications

We'll need to lock kernels to their relevant transactions (or repo versions) to prevent
untested configurations. Additionally the boot menu will need to know about older versions
of the OS that are installed, so they can be activated in the `initrd` at boot. This
will require us doing some work with `clr-boot-manager` to achieve our goals.

#### Difference from existing solutions

We're trying to minimise the iterations of the OS to what is available in a given version
of the package repositories. Additionally we wish to avoid extensive "symlink farms"
as we're not a profile-oriented distribution. Instead we focus on deduplication, atomic
updates and resolution performance.

#### Subscriptions

Keeping a system slim is often a very difficult thing to achieve, without extensive
package splitting and effort on the user's part. An example might be enabling SELinux
support on a system, or culling the locales to only include the used ones.

In Serpent OS (and moss, more specifically) we intend to address this through "subscriptions".
Well defined names will be used by moss to filter (or enable) certain configurations
in packages + dependencies. In some instances this will toggle subpackages/dependencies
and in others it will control which paths of a package are actually installed to disk.

Going further with this concept, we will eventually introduce modalias based capabilities
to automatically subscribe users to required kernel modules, allowing slim or fullfat
installations as the user chooses. This in turn takes the burden of maintainence away
from developers + users, and enables an incredibly flexible, approachable system.

#### Mandatory reboots

Where possible we will limit mandatory reboots, prefering an in-place atomic update
to facilitate high uptime. However, there are situations where a reboot is absolutely
unavoidable, and the system administrator should plan some downtime to handle this
case.

Certain situations like a kernel update, or security fix to a core library, would
require a reboot. In these instances, the atomic update will be deferred until the
next boot. In most situations, however, reboots will not be mandatory.

#### Until the next time

Well, we've given a brief introduction to our aims with `moss` and associated tooling,
and you can get more information by checking the moss [README.md](https://github.com/serpent-linux/moss/blob/main/README.md).

The takeaway is we want a package-based software update mechanism that is
reliable and trusted, and custom-built to handle Serpent OS intricities,
with a simple approach to building and maintaining the distribution.

For now, we're gonna stop talking, and start coding.
