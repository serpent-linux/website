---
title: "Stage 3 Progress"
date: 2020-08-20T14:14:49+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/stage3-progress/screenshot.png"
---

Well, it's been a few days since we last spoke, so now it's time for a quick
roundup. Long story short, we're approaching the end of the stage3 bootstrap.

{{<figure_screenshot_one image="stage3-progress/screenshot" caption="Fully functional chroot">}}

In an effort to simplify our bootstrap process, we dropped the newly-introduced `stage2.5` and
came up with a new strategy for `stage3`. In order to make it all work nicely, we bind-mount the
`stage2` resulting runtime at `/serpent` within the `stage3` chroot environment, executing the
`/serpent/usr/bin/bash` shell.

In order to make this work, we build an intermediate `musl` package for `libc.so` in the very
start of `stage3`, with all subsequent builds being performed in chroots. Part of the build
is done on the host, i.e. extraction and patching, minimising the tool requirements for the chroot
environment. The configuration, build and install is performed from within the initially empty
chroot environment, replacing all the `/serpent/usr/bin` tools and `/serpent/usr/lib` libraries.

### Mild Blockers

As we move further through stage3, towards a fully usable chroot environment, we've encountered
a small number of blockers. Now, we **could** solve them by using existing patchwork and workarounds,
but most have not and will not be accepted upstream. Additionally it is incredibly hard to track the
origin and history of most of these, making security rather more painful.

#### libc-support

We're going to start working on a project to flesh out the `musl` runtime with some missing utilities,
written with a clean-room approach. These will initially include the `getconf` and `getent` tools,
which will be written only with Linux in mind, and no legacy/BSD support.

These will be maintained over at our [GitHub](https://github.com/serpent-linux/libc-support)

#### libwildebeest

As a project we strive for correctness in the most pragmatic way. Some software, such as systemd,
is heavily reliant on GNU GCC/GLibc extensions. In some software there are feasible alternatives
when using musl, however in a good number of cases, functionality required to build certain
software is missing and has no alternative.

Over time we'll try to work with upstreams to resolve those issues, but we're working on an interim
solution called 'libwildebeest'. This will provide **source compatibility** for a limited number
of software packages relying on so-called 'GNUisms'. Binary compatibility is not an aim whatsoever,
and will not be implemented. This convenience library will centralise all patchwork on packages
that need more work to integrate with musl, until such time as upstreams have resolved the remaining
issues.

Additionally it will help us track those packages needing attention in the distribution, as they
will have a build-time dependency on `libwildebeest`. We do not intend to use this project extensively.

This will be maintained over at our [GitHub](https://github.com/serpent-linux/libwildebeest)

### A Word On Init Systems

Recently we've had many queries regarding the init system, as there is an expectation that due to our
use of musl/llvm we also dislike systemd or wish to be a small OS, etc. There is a place in the world
for those projects already, and we wish them much success. However from our own stance and goals,
`systemd` has already "won the battle" and actually fits in with our design.

**If** it is possible in future with package manager considerations and packaging design, then we may
make it possible to swap `systemd` for a similar set of packages. However, we only intend at this time
to support `systemd/udev/dbus` directly in Serpent OS and leave alternatives to the community.

### Other News

Just a quick heads up, we've been talking to the cool folks over at [https://fosshost.org/](fosshost.org)
and they've agreed to kindly provide us with additional hosting and mirroring. This will allow us to
build scale in from the very start, ensuring updates and images are always available. Once the new server
is up and running we'll push another blogpost with the details and links.

While initially we intended to avoid public bug trackers, the rate of growth within the project and community
have made it highly apparent that proper communication channels need establishing. Therefore we will be
setting up a public Phabricator instance for reporting issues, security flaws, and contributing packaging.

Much of our website is in much need of update, but our current priority is with building the OS. Please
be patient with us, we'll have it all sorted out in no time.

#### Where We At?

Well, stage3 completes fully, builds the final compiler, which has also been verified. A usable chroot
system is produced, built using `musl`, `libc++`, `libunwind`, `clang`, etc. Some might say that stage3
is complete, however we wish to avoid circular dependency situations. We'll mark stage3 as complete once
we've integrated an initial slimmed down build of `systemd` and appropriately relinked the build.

As soon as this stage is done, we'll proceed with `stage4`. This is the final stage where we'll add
package management and define the OS itself, with global flags, policies, etc.

With the speed we're moving at, that really isn't too far away.

#### And finally..

I personally wish to thank the Sepent OS team as a whole for the commitment and work undertaken of late.
Additionally I want to thank the growing community around Serpent OS, primarily residing in our IRC
channel (`#serpentOS` on freenode) and our Twitter account. Your input has been amazing, and it's
so refreshing to have so many people on the same page. Stay awesome.
