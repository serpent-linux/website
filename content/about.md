---
title: "About"
date: 2020-06-30T16:39:03+01:00
draft: false
---

Serpent OS is (or at least, will be) a Linux distribution with notably different goals
from the mainstream offering. We're in the process of establishing the project, with
development properly starting towards the end of July.

#### Naming

Eventually our plan is to rebrand as 'Serpent Linux\*' - however we will first need to
complete some early donkey work and apply for a sublicense to use the name. As explained
below, this is _not_ Serpent 'GNU/Linux' as the distribution will not be dependent on
a GNU toolchain or runtime. For those who are curious, we're working with an artist to
choose an appropriate logo for the project.

#### Aims

The vast majority of Linux distributions have highly similar goals, and can be best
described using these common industry buzzwords:

    Modern, lightweight, privacy oriented/respecting, user-friendly desktop

We're focused on building a Linux distribution that serves our own needs.
Chiefly, a Linux distribution for people who want to use Linux, not a "Linux-based-OS"
focusing on interoptability with macOS\* + Windows\*.

In a nut shell, this is __not__ "Linux for the masses". This is a project setting out to
use Linux as Linux should be used. This will in turn help us to build a significantly
advanced Linux distribution that is both modular and optimised for modern machines.

#### A Truly Modern Linux Distribution

As we're taking a distro-first, compatibility-later approach, our design decisions
will allow us to take some bold steps. We'll also be able to incorporate all of the
more sensible design improvements in Linux distribution design over the last decade or
so:

 - No more usrbin split
 - 100% clang-built throughout (including kernel)
 - musl as libc, relying on compiler optimisations instead of inline asm
 - `libc++` instead of `libstdc++`
 - LLVM's binutils variants (`lld`, `as`, etc.)
 - Mixed source/binary distribution
 - Moving away from `x86_64-generic` baseline to newer CPUs, including Intel and AMD specific optimisations
 - Capability based subscriptions in package manager (Hardware/ user choice / etc)
 - `UEFI` only. No more legacy boot.
 - Completely open source, down to the bootstrap / rebuild scripts
 - Seriously optimised for serious workloads.
 - Third party applications reliant on containers only. No compat-hacks
 - Wayland-only. X11 compatibility via containers will be investigated
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

We will only accept community involvement via our IRC channel: `#serpentOS` on Freenode.
We will not operate a public bug tracker or forums. Once we are past out initial bootstrap
phase we will set up an email address to help reporting security issues to the team, and
we will of course release security notices.

In terms of feature requests, these will be largely at the discretion of core contributors.
When a company has been formed to house this project, we're happy to hash out an SLA for
required works.

#### Timescale

It may seem incredibly odd launching a website before there is a distro to show off, however,
it became very apparent that the cat would be out of the bag, so we wanted to be prepared.

Currently, the Founder is in the midst of relocating to the Republic of Ireland. Once complete
we'll move to stage2 of our bootstrap process and begin working on the tooling needed for the
base development.
