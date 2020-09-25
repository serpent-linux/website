---
title: "Rebootstrapped With Glibc"
date: 2020-09-25T14:23:28+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/rebootstrapped-with-glibc/Featured.png"
---

Only a few days ago we told you of our switch from `musl` to `glibc`. That has now been implemented
in the `bootstrap-scripts` project. The rebootstrap is complete and we now have GCC, LLVM, binutils and
glibc offering a hybrid toolchain. Most software is built and linked with clang, however linking with
libgcc is possible both dynamically and statically.

Our next steps are fairly logical, but feel free to have a read.

{{<figure_screenshot_one image="rebootstrapped-with-glibc/Featured" caption="Semi-functional systemd-nspawn">}}

#### Enable early multilib support

Having established our goals, it is clear we also need to support 32-bit binaries on a 64-bit
Serpent OS installation, such as Steam. We'll add multilib support to our bootstrap to ensure
we ship with support for these 32-bit binaries very quickly.

#### Validate AArch64 support

We made a bit of a mess in switching to glibc, so, we'll go back and build for aarch64 and fix any fallout.
It is still important we target this architecture, as the community explicitly requested support for the
Raspberry Pi 4!

#### Pivot back to moss

We had to get this bootstrap out of the way before it became a growing issue. While it's still "dirty" and
some paths or configurations are not to our liking, the groundwork is sufficient to enable developing moss
now.

Our first port of call is to develop the build side of moss, i.e. emitting binary packages that can then
be installed to form a rootfs.

#### Timescale

It actually all depends on moss now. Once moss can produce packages we can firmly put ourselves into stage4
and have package git repositories on our infrastructure, and open up contributions from the community. We
intend to build a **sustainable** contribution led ecosystem so we can all get back to doing what we love
most, using Linux on a daily basis to get stuff done.

Some of you may know my significant other is expecting a child, or rather, she was expected yesterday.
When this situation changes I will of course take some downtime to help the growing family and then
return to work.

#### Support

At the time of writing, 18 amazing individuals have contributed to us on our [Open Collective](https://opencollective.com/serpent-os).
On behalf of the team, I want to thank you from the bottom of our hearts. Once we leave bootstrap, we'll
dedicate ourselves to providing you with a reliable, up to date operating system that is always on the edge
and always safe to upgrade, enabling you to do what **you** want to do. Our team has extensive and
somewhat unique experience in building custom systems with high performance and reliability that
caters for everything from devops to gaming.

When the project funds are high enough we'll order Raspberry Pis for myself and Peter to fully enable
AArch64, and a new build box as my laptop is somewhat dated now. With your help, we can achieve
the impossible, as a community.
