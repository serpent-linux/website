---
title: "Scaling Our Infrastructure"
date: 2020-08-22T14:25:56+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/scaling-our-infrastructure/featured.png"
---

While it might look like we haven't been up to much lately, the exact opposite is true.
We've been busy scaling our infrastructure in preparation for the upcoming `stage4`
bootstrap..

### fosshost.org sponsors Serpent OS

Recently we've been in talks with [fosshost.org](https://fosshost.org) who have very kindly
agreed to sponsor the project through additional hosting and mirrors. We've been provided
with a server in Maidenhead, UK, which we've just finished configuring. Per our talks, as
our project grows, so will the hosting support.

{{<figure src="/img/fosshost.org_Cloud_Light.png" width="20%" height="20%" link="https://fosshost.org">}}


This has enabled to get our infrastructure ready in ancticipation of the `stage4` bootstrap,
which is only around the corner now.

### Wildcard SSL Certificate

As part of our expansion, Aydemir has purchased a wildcard SSL certificate for our domains lasting
2 years, as part of ensuring our longevity. This has been deployed across two of our subdomains,
and will soon be deployed on this website too.

### Phabricator

We now have a brand-spanking-new Phabricator instance running at [dev.serpentos.com](https://dev.serpentos.com).
This will be used for tracking issues, hosting repositories and will become a central pillar of our
community. All major development will happen on this new tracker, which is linked through the header
of this page.

You can sign up with a username, or login via GitHub. All new members are required to verify their
email address, and some may have to pass a reCAPTCHA challenge. This is to help limit the amount of
spam on the new site.

{{<figure_screenshot_one image="scaling-our-infrastructure/featured" caption="Our newly installed Phabricator">}}

Please note we're not accepting package requests at this moment in time, and generic 'Why??' issues not
relating to development will be closed as they only serve to derail work on the project, by taking away
valuable time.

### Download server

Our download server currently lives at [download.serpentos.com](https://download.serpentos.com) and co-exists
with the Tracker. We expect to serve downloads and repositories at this address for the `stage4` bootstrap.

### Mirrors

`fosshost` have also kindly integrated the Serpent OS servers into their mirror network. Currently you can find us
at these locations:

 - https://uk.mirrors.fossho.st/serpentos/
 - https://us.mirrors.fossho.st/serpentos/

Right now there is no content to download until such point as stage4 progresses.

### Moving Our Repositories

Our `bootstrap-scripts` repository has migrated from GitHub to our internal hosting. You can find it here:

 - https://dev.serpentos.com/source/bootstrap-scripts/

It is adviseable to re-clone the project, as we've migrated from the `master` branch to the `main` branch.
All future Serpent OS repositories will now default to this branch, enabling more logical naming of
branches (`main/edge`).

### Privacy Policy

To ensure that our users are comfortable, and ensure compliance with the GDPR, we've deployed an updated
privacy policy which can be found [here](/privacy/). This can be found in the top header of the website
at any time.

### A Final Word

We want to extend our warmest thanks to [fosshost.org](https://fosshost.org) for their early support of
the project, as it will ensure we have scale builtin from the outset to better serve our users.

Additionally, many thanks to the team and community for recent work and assistance in getting everything
set up and running.

If you're interested in our Sponsorships, please visit the new [Sponsors](/sponsors) page.
