---
title: "Source Format Defined"
date: 2020-09-21T16:09:46+01:00
draft: false
type: "post"
authors: [ikey]
categories: [news]
featuredImage: "/img/blog/source-format-defined/Featured.png"
---

Following quickly on the heels of yesterday's announcement that the binary format has been defined, we've
now implemented the initial version of our source format. The source format provides metadata on a package
along with instructions on how to build the package.

The next step of course, is to implement the build tool, converting the source specification into a binary package
that the end user can install. With our 2 formats defined, we can now go ahead and implement the build routines. 

{{<figure_screenshot_one image="source-format-defined/Featured" caption="A very trivial package spec">}}

### A YAML based format

The eagle-eyed among you will already see this is a derivation of the `package.yml` format I originally created
while at [Solus](https://getsol.us). Minor adaptations to the format have been made to support multiple architectures
via the `profiles` key, and package splitting behaviour has now been grouped under a `packages` key to make
the structure more readable.

In `package.yml`, one would have to redefine subpackage summaries as a key in a list of the primary `summary` key,
such as:

```yaml

    rundeps:
        - primary-run-dep
        - dev: secondary-run-dep
    summary:
        - Some Summary
        - dev: Some different summary
```

We've opted to group "Package Definition" behaviour into core structs, which are allowed to appear in the root-level
package and subpackages:

```yaml

    summary: Top-level summary
    packages:
        - dev:
            summary: Different summary
            rundeps: Different rundeps
```

### Multiple architecture support

In keeping with the grouping behaviour, we're baking multiple architecture configurations into the YML file. A common
issue encountered with the older format was how to handle `emul32`:

```yaml

    setup: |
        if [[ -z "${EMUL32BUILD}" ]]; then
            %configure --some-emul32-option
        else
            %configure
        fi
...
    build: |
        %make
...
```

Our new approach is to group Build Definitions into the root level struct, which may then individually be overriden for
each architecture. For example:

```yaml

    profiles:
        - ia32:
            setup: |
                %configure --some-emul32-option
...
    setup: |
        %configure
...
```

{{<figure_screenshot_one image="source-format-defined/Permutations" caption="More advanced uses of the spec">}}

### Differences

As you can see it is highly similar to package.yml - which is a great format. However, with our tooling and aims being
slightly different, it was time to reevaluate the spec and bolster it where appropriate. We're happy to share our
changes, but in the interest of not causing a conflict between the 2 variants, we'll be calling ours "stone.yml".

Our main motivation came from the tooling, which is written in the D language. With D we were able to create a strongly
typed parser and explicit schema, and with a struct-based approach it made it more trivial to group similar
definitions.

Other than that, we have the same notions with the format, intelligent automatic package splitting, ease of developer
experience, etc.
