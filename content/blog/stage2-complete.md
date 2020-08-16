---
title: "Stage2 Complete"
date: 2020-08-16T15:08:08+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/stage2-complete/Featured.png"
---

Just in case you thought we were sleeping behind the wheel, we've got
another blogpost for your viewing pleasure. In a nutshell, we completed
stage2 bootstrap.

{{<figure_screenshot_one image="stage2-complete/Featured" caption="Complete build-target for ARMv8">}}

In order to simplify life, we greatly reduced the size of the `stage2` build component.
This decision was taken to better support cross-compilation in the face of software that
is distinctly cross-compilation unfriendly.

A support stage, `stage2.5` will be added which will `chroot` into a copy of `stage2`, and
natively compile a small handful of packages required to complete `stage3`, also within the
chroot environent.

For cross-compilation, we'll be relying on `qemu-static` to complete `2.5` and `3`.
However, at this point in time, we have the following:

 - Working cross-compilation of the entire bootstrap
 - Complete LLVM based toolchain: `clang`, `llvm`, `libc++`, `lib++abi`, `libunwind`
 - Entirety of stage2 built with `musl` libc.
 - Working, minimal, `chroot` environment as product of `stage2`, with working compiler (`C` & `C++`)

{{<figure_screenshot_one image="stage2-complete/x86_64" caption="Working x86_64 chroot">}}

This is a major milestone for the project, as it is an early indication that we're self hosting.

### Multiple Architecture Support

At this point in time, we now have build support for two targets: `x86_64` and `ARMV8a`.
Our intent is to support `haswell` and above, or `zen` and above, for the x86_64 target.

With our `ARMv8` target, we're currently looking to support the Pine Book Pro, if we can
manage to get hold of some testing hardware. It will likely be some time after full
x86_64 support that we'd officially support more hardware, however it is very important
that our bootstrap-scripts can trivially target multiple platforms.

{{<figure_screenshot_one image="stage2-complete/ARMv8" caption="ARMv8 validation">}}

An interesting change when cross-compiling for other architectures, is the chicken & egg
situation with `compiler-rt` and other LLVM libraries. When we detect cross-compilation,
we'll automatically bootstrap `compiler-rt` before building `musl`, and then cross-compile
`libc++`, `libc++abi` and `libunwind` to ensure `stage1` can produce native binaries for
the target with correct linkage.

### Next Steps

As we've mentioned, we'll push ahead with `2.5` and `3`, which will complete the inital
Serpent OS bootstrap, producing a self-hosting, self-reliant rootfs. This is the point
at which we can begin to bolt-on package management, boot management, stateless configuration
utilities, etc.

Our initial focus is `x86_64` hardware with UEFI, and as we gain access to more hardware we
can enable support for more targets, such as `ARMv8a`. Our `bootstrap-scripts` will always
remain open source, as will all processes and tooling within Serpent OS, or anything used
to build and deploy Serpent OS.

This will make it much easier in future to create custom spins of Serpent OS for different
configurations or targets, without derailing the core project. It should therefore be the
simplest thing in the world to fork Serpent OS to one's liking or needs.

If you want to support our work, you can jump onto our IRC channel (`#serpentOS` on freenode)
or support us via the [Team page](/team).

### Updated Roadmap

{{<roadmap_bootstrap>}}
