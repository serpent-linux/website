---
title: "Download"
date: 2020-09-13T20:07:13+01:00
draft: false
Callout: "Grab them ISOs"
---

## Aw, shucks

Looks like we haven't released any ISOs yet!

In the mean time, you can experiment with our Docker image on x86_64.

```bash

 $ docker run -it --rm serpentos/staging:latest

```

**Warning**: This Docker image is currently built from our bootstrap-scripts
repository using the result of `stage3`. It should NOT be used in production
environments, and lacks security patches and various integrations.

This image is not in any way indicative of our final vision, it is just
a useful way to keep up with developments as they happen, and to validate
the LLVM/musl toolchain.
