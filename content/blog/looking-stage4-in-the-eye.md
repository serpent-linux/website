---
title: "Looking Stage4 In The Eye"
date: 2020-08-28T21:35:16+01:00
draft: false
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/looking-stage4-in-the-eye/FeaturedSD.png"
---

Well, we've made an awful lot of progress in these last few days. It wasn't
that long ago that we introduced some of the new projects required to get
stage3 off the ground.

{{<figure_screenshot_one image="looking-stage4-in-the-eye/FeaturedSD" caption="Building systemd the easy way">}}

#### libc-support

Our [libc-support](https://dev.serpentos.com/source/libc-support/) project has been growing, thanks primarily to the contributions
of [Jouni Roivas](https://dev.serpentos.com/p/joroi/). We now have initial working versions
of `getent` and `getconf`. The `getconf` program is considered feature-complete
for our current requirements, and the focus is now on cleaning up `getent` making
it more modular and easy to maintain in the long run.

#### libwildebeest

We began work on [libwildebeest]https://dev.serpentos.com/source/libwildebeest/ to quickly unlock building `systemd`.
Remember, our ambition with this project is to provide a sane, centralised way of
maintaining source compatibility with various projects that rely on features currently
only available in the GNU toolchain + runtime. This is our alternative vision to
patching every single package that fails to build against our LLVM+musl toolchain,
ensuring our work scales.

Right now, `libwildebeest` implements some missing APIs, and indeed, some **replacement** APIs,
for when GNU behaviours are expected. It does so in a way that doesn't impact the
resulting binary's license, or any of the system ABI. We provide some `pkg-config` files
with explicit `cflags` and `libs` fields set, such as:

```bash

      -L${libdir} -lwildebeest-ftw -Wl,--wrap=ftw -Wl,--wrap=nftw -I${includedir}/libwildebeest --include=lwb_ftw.h
```

Our headers take special care to **mask** the headers provided by musl to avoid redefinitions,
and instruct the linker to replace calls to these functions with our own versions, i.e.:

```c

int __wrap_ftw(const char *dir, int (*funcc)(const char *, const struct stat *, int),
               int descriptors)

```

It then becomes trivial to enable wildebeest for a package build, i.e.:

```bash
        export CFLAGS="${CFLAGS} $(pkg-config --cflags --libs libwildebeest)"
```

Right now - we've only provided stubs in `libwildebeest` to ensure we can build our packages.
Our next focus is to actually implement those stubs using MIT licensed code so that applications
and libraries can rely on `libwildebeest` to provide a basic level of GNU compatibility in a
reliable fashion.

Until such point as all the APIs are fully and safely implemented, it would be highly ill-advised
to **use** libwildebeest in any project. We'll announce stability in the coming weeks.

#### systemd

We've made great progress in enabling systemd in Serpent OS. Where `libwildebeest` is in
place, it now enables our currently required level of source compatibility to a point where
systemd is building with networkd, resolved and a number of other significant targets enabled.

In a small number of cases, we've had to patch systemd, but not in the traditional sense
expected to make it work with musl.

The only non-upstreamable patching we've done (in combination with libwildebeest enabling)
was to the UAPI headers, as the musl provided headers clash with the upstream kernel headers
in certain places (`if_ether.h`, `if_arp.h`) - but this is a tiny cost to bear.

The other patches, were simply portability fixes, ensuring all headers were included:

 - [partition/makefs: Include missing sys/file.h header #16876](https://github.com/systemd/systemd/pull/16876)
 - [login/logind: Include sys/stat.h for struct stat usage #16887](https://github.com/systemd/systemd/pull/16887)

It should be noted both of these (very trivial) pull requests were accepted and merged upstream,
and will be part of the next systemd release.

#### Next On The Agenda

Our major ticket items involve fleshing out stage3 with some missing libraries to further
enable systemd, rebuilds of util-linux to be systemd-aware, and continue fleshing out
`dbus`, `systemd` and `libwildebeest` support to the point we have a bootable disk image.

At that point we'll move into stage4 with package management, boot management, and
a whole host of other goodies. And, if there is enough interest, perhaps some early
access ISOs!

After having engaged in discussions with a variety of developers using musl as their
primary libc, we've catalogued common pain points. We therefore encourage developers
to contribute to our `libwildebeest` and `libc-support` projects to complete the
tooling and experience around musl-based distributions.

Our aim for Serpent OS is a **full fat experience**, which means we have large ticket
items on our horizon, such as NSS/IDN integration, performance improvements, increasing
the default stack size, along with source compatibility for major upstream projects.

Until the next blog post, you can keep up to date on our IRC channel. Join `#serpentOS` on freenode!
