---
title: "Results Of The Experiment"
date: 2020-09-22T18:05:39+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/results-of-the-experiment/Featured.png"
---

It seems like only yesterday we announced to the world a [Great Experiment](https://serpentos.com/blog/2020/07/01/the-great-experiment/).
It was in fact 2 months ago, and a whole lot of work has happened since that point. A few take-homes are immediately clear, the primary
one being the need to be a community-oriented Linux distribution.

To quote ourselves 2 months ago:


```
 If the experiment is a success, which of course means having tight controls on scope and timescale,
 then one would assume the primary way to use Serpent OS would be through some downstream repackaging
 or reconfiguration, i.e. basing upon the project, to meet specific user demand.
```

It turns out that so far the experiment has been successful, and being forkable is still at the very
heart of our goals. Others have joined us on our journey, and expressed the same passion in our goals
as we have. A community has formed around the project, with individuals sharing the same ambitions
for a reliable, rolling operating system with a powerful package manager.

{{<figure_screenshot_one image="results-of-the-experiment/Featured" caption="A very trivial package spec">}}


#### An open community

Over the past 2 months we've transformed from set of ideas into a transparent, community-first organisation
with clear leadership and open goals. I've stepped into the Benevolent Dictator For Life position, and Peter
has taken on daily responsibilities for the project running. Aydemir is now our treasurer on Open Collective,
and many individuals contribute to our project.

#### Transactional package mangement

No need to rehash this, but the defining feature of Serpent OS has clearly become moss, something initially
not anticipated when we started. A read-only root filesystem, transactional operations, rollbacks, deduplicating
throughout and atomic updates. Combine that with a rolling release model, stateless policy and ease-of-use,
the core feature-set is already powerful.

#### Deferral of musl integration

In recent weeks we've been working on `libwildebeest` and `libc-support`, primarily as a stop-gap to provide
glibc compatibility without using glibc. While musl has many advantages, it is clear to us now that writing
another libc through our support projects isn't what we originally planned. With that in mind we're adopting
glibc and putting our musl works under community ownership, until such time as reevaluation shows that musl is
what is needed in Serpent OS. Note the primary motivator here is investing our efforts where it makes sense,
and obtaining the best results in the most manageable fashion for our users.

Our new toolchain configuration will be as follows:

 - LLVM/clang as primary toolchain
 - libc++ as C++ library
 - glibc as C library
 - gcc+binutils (`ld.bfd`) provided to build glibc, elfutils, etc.
 - Permitting per-package builds using GCC, i.e. kernel to alleviate Clang IAS issues.

Thus our toolchain will in fact be a hybrid GNU/LLVM one. This will allow both source and binary compatibility
with the majority of desktop + server Linux distributions, facilitating choice of function for our users.

It should be noted this decision has been made after much discussion internally, on our IRC, on our OpenCollective,
etc. Our bootstrap-scripts is being improved to support both `glibc` and `musl`, so that the decision can continuously
be reviewed. If we reach a position whereby musl inclusion once again makes sense, thanks to atomic updates
from moss, it will be possible to switch.

#### Final thoughts

Initially Serpent OS emerged as a collective agreement on IRC as a set of notions as opinions. Over the past few
months those opinions have solidified into tangible ideas, and a sense of community. In keeping with what is
right for the community, our messaging has been reworked.

It is fair to say our initial stance appeared quite hostile, as a bullet-point list of exhaustion with past
experiences. As we've pivoted to being a fully community-oriented distribution, we've established our goals
of being a reliable, flexible, open, rolling Linux distribution with powerful features imbued by the
package manager, and an upstream-first approach.

As such we've agreed to not let our own pet-peeves interfere with the direction of the project, and instead
enable users to do what they wish on Serpent OS, be it devops, engineering, browsing, gaming, you name it.
We're a general purpose OS with resilience at the core.

Our focus is on the usability and reliability of the OS - thus our efforts will be invested in areas such
as the package manager, hardware enabling, the default experience, etc.

So, strap yourself in, as we're fond of saying. Development of Serpent OS is about to accelerate rapidly.
