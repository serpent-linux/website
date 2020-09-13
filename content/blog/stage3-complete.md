---
title: "Stage3 Complete"
date: 2020-09-07T18:39:24+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/stage3-complete/Featured.png"
---

Another week, another milestone completed. We're pleased to announce that
we've completed the initial Stage3 bootstrap. While we have some parallel
works to complete for Stage 4, we can now begin to work on the exciting
pieces! We're now bootstrapped on ARMv8(-a) and x86_64

{{<figure_screenshot_one image="stage3-complete/Build" caption="Complete build-target for x86_64">}}


### Announcing Moss

Our immediate focus is now to implement our package manager: [moss](https://github.com/serpent-linux/moss).
Currently it only has a trivial CLI and does absolutely nothing. We will now shift our focus
to implement this as a core part of the Stage 4 bootstrap. Moss is so-called as we're a rolling
release, _a rolling stone gathers no moss_. The package manager is being implemented in the D Programming Language.

Moss does not aim to be a next generation package management solution, it instead inspired by
eopkg, RPM and swupd, aiming to provide a reliable modern package management and update
solution with stateless design at the core. Core features and automatic dependencies will be managed
through capability subscriptions. The binary format will be versioned and deduplicated, with multiple
internal lookup tables and checksums. Our chief focus with moss is a reliable system
management tool that is accessible even in situations where internet access is limited.

### Ongoing Works

In order to complete stage3, we provided linker stubs in `libwildebeest` to ensure
we can build. Obviously this introduces runtime errors in systemd and our stage3 isn't
bootable, just chrootable. This will be resolved when systemd is properly packaged by
moss in stage4.

### Docker Image

We now have a test container available on Docker Hub. You can install and run the
simple bash environment by executing the following command with a Docker-enabled user:

```bash
    docker run -it --rm serpentos/staging:latest
```

Currently we only have an x86_64 image, but may experiment with multiarch builds later
in stage4.

**IMPORTANT**: The `staging` image is currently only a dump of the stage3 tree with
minor cleaning + tweakups. It is not, in any way, shape or form, representative of
the final quality of Serpent OS. Additionally zero performance work or security
patching has been done, so do **not** use in a production environment.

The image is provided currently as a means to validate the LLVM/musl toolchain.

{{<figure_screenshot_one image="stage3-complete/Featured" caption="Serpent OS stage3 Docker image">}}

### Future ISO

We cannot currently say when we'll **definitely** have an ISO, however we do
know that some VM-specific images will arrive first. After that we'll focus
on an installer (package selection based) and a default developer experience.
All we can say is strap in, and enjoy the ride.

### Updated Roadmap

{{<roadmap_bootstrap>}}
