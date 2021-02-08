---
title: "Cleanups Complete"
date: 2021-02-08T11:50:46Z
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/cleanups-complete/Featured.png"
---

Well, we're officially back to working around the clock. After spending
some time optimising my workflow, I've been busy getting the entire codebase
cleaned up, so we can begin working towards an MVP.

<!--more-->

{{<figure_screenshot_one image="cleanups-complete/Featured" caption="Lots and lots of work">}}

#### Codebase hygiene

Since Friday, I've been working extensively on cleaning up the codebase for the
following projects:

 - boulder
 - moss
 - moss-core
 - moss-format

As it now stands, 1 lint issue (a non-issue, really) exists across all 4
projects. A plethora of issues have been resolved, ranging from endian correctness
in the format to correct idiomatic D-lang integration and module naming.

#### Bored

Granted, cleanups aren't all that sexy. Peter has been updating many parts of
the bootstrap project, introducing systemd 247.3, LLVM 11.0.1, etc. We now have
all 3 stages building correclty again for the x86_64 target.

#### And then....

Yikes, tough audience! So we've formed a new working TODO which will make its
way online as a public document at some point. The first stage, cleanups, is
done. Next is to restore feature development, working specifically on the
extraction and install routines. From there, much work and cadence will be
unlocked, allowing us to work towards an MVP.

{{<figure_screenshot_one image="cleanups-complete/TODO" caption="See, we organised stuff">}}

#### You keep saying MVP..

I know, it makes me feel all ... cute and professional. At the moment we're cooking up
a high level description of how an MVP demonstration could be deployed. While most of
the features are ambiguous, our current ambition is to deploy a preinstalled QCOW2
Serpent OS image as a prealpha to help validate moss/boulder/etc.

It'll be ugly. Likely slow. Probably insecure as all hell. But it'll be **something**.
It'll allow super basic interaction with moss, and a small collection of utilities that
can be used in a terminal environment. No display whatsoever. That can come in a future
iteration :)

ETA? ~~Definitely not by the 28th February~~. When it's done. 

{{<giphy "qs6ev2pm8g9dS">}}
