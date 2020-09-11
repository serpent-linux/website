---
title: "About"
date: 2020-06-30T16:39:03+01:00
draft: false
---

Serpent OS is building a pioneering new Linux distribution, with a focus on cutting edge technologies in a 100% open source project.

Our aims:

 - Infinitely forkable
 - Infinitely flexible
 - Infinitely reliable

#### Naming

Eventually our plan is to rebrand as 'Serpent Linux\*' - however we will first need to
complete some early donkey work and apply for a sublicense to use the name.

#### Logo

Our logo was kindly contributed by Rıza Türker.

#### A Pioneering Linux Distribution

As we're taking a distro-first, compatibility-later approach, our design decisions
will allow us to take some bold steps. We'll also be able to incorporate all of the
more sensible design improvements in Linux distribution design over the last decade or
so:

 - No more usrbin split
 - 100% clang-built throughout (including kernel)
 - musl as libc for improved portability and debugging
 - `libc++` instead of `libstdc++`
 - LLVM's binutils variants (`lld`, `as`, etc.)
 - Mixed source/binary distribution
 - Moving away from `x86_64-generic` baseline to newer CPUs, including Intel and AMD specific optimisations
 - Capability based subscriptions in package manager (Hardware/ user choice / etc)
 - `UEFI` only for `x86_64` hardware. No more legacy boot.
 - Completely open source, down to the bootstrap / rebuild scripts
 - Seriously optimised for serious workloads.
 - Third party applications reliant on containers only. No compat-hacks
 - Wayland-only. X11 compatibility via containers will be investigated
 - Fully stateless with management tools and upstreaming of patches
 - Atomic updates + rollbacks with a seriously powerful package manager
 - Read only rootfs for improved security
 - Live kernel patching
 - Lots, lots more. We'll blog about it.

#### Opinionated By Default

A recurring theme that holds back the development of world-class Linux, is high tolerance
for those holding Linux back. A perfect example is NVIDIA\* and their lack of support for
accelerated Wayland support on their GPUs. Consequently, our project won't tolerate such
decisions and will instead blacklist the NVIDIA proprietary drivers from the distribution.

There are other examples that will emerge over time, and will become quite clear.

The time for Linux distributions giving in, with thousands of man hours wasted working around
negative actors, had come to an end.

#### Support / Community

Most development discussions happen on our IRC channel, `#serpentOS`, which can be found on
freenode. You can join our [Phabricator](https://dev.serpentos.com) instance to contribute code, ideas and fixes, or
even our [GitHub](https://github.com/serpent-linux).
