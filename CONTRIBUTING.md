# Contributing to the Unison Base libraries (DEPRECATED) 

Hi. 😀 We welcome you to contribute to the Unison base libraries. This doc is considered deprecated, instead [head to Unison Share](https://share.unison-lang.org/@unison/base) and check out the "Tickets" tab to see if there are any open issues that you'd like to tackle. Then follow our guide for Creating a Pr: https://www.unison-lang.org/docs/tooling/project-workflows/#creating-a-pr to submit a contribution! 

Please read our [Code of Conduct](https://www.unisonweb.org/code-of-conduct) to ensure our community remains as friendly as possible.

## About this document

This is a guide for submitting pull requests to this project. It details:

* The layout of the code.
* The logistics of creating a pull request to the Base libraries.
* Criteria for what should be included in these libraries and what should not.
* Standards of quality that pull requests must meet.

These are just guidelines, not rules. Contributors need to exercise some judgment in applying these guidelines to individual pull requests, but this document should help everyone know what to expect.

## What should be in Base?

There is no one rule for what should be included in the Base libraries, but contributors should heed the following guidelines.

### No external dependencies

Base should not have any dependencies on other libraries, so functionality should include any and all code it requires.

### Dependencies of Unison tooling

Base needs to include any functionality required to support the Unison compiler, Codebase Manager, and other basic tooling. An example of this kind of thing is the [`base.Doc`](https://share.unison-lang.org/latest/namespaces/unison/base/;/types/Doc) type.

### Batteries included

The purpose of the Base libraries is to help developers to be productive from the beginning, without having to hunt for a bunch of libraries to do basic stuff. Anything that's likely to be useful to most developers should be considered for inclusion in Base.

Conversely, things should not be in Base unless they're likely to see use by a lot of developers for different applications. Specialized functionality, or code that's unlikely to see much use, should generally not be in Base.

Examples of universally useful things are the [`compose`](https://share.unison-lang.org/latest/namespaces/unison/base/;/terms/compose) function and the [`List`](https://share.unison-lang.org/latest/namespaces/unison/base/;/types/List) data type.

### Standard implementations

For certain functions and types that lots of developers need, it can be counterproductive to have many competing implementations or representations. Sometimes there's even an obvious "best" implementation. For these, it's best to standardize on one and include it in Base. An example of this is [`base.List`](https://share.unison-lang.org/latest/namespaces/unison/base/;/types/List).

Conversely, sometimes developers can benefit from having more than one implementation of a function or type to choose from for different applications. Such things should be excluded from Base unless they're very simple. An example of the kind of thing that should be excluded is an [HTTP client](https://share.unison-lang.org/latest/namespaces/stew/http/;/terms/README).

### No novelty

Code in Base should generally be of the kind that sits in well-explored design spaces. If something is highly novel, cutting-edge research, or a current fad, it should probably not be in Base.

### Stability

It's important that Base stay relatively stable. Code that's likely to change frequently, or see design churn or rapid development cycles, should generally not be in Base.

### No controversy

Code in Base should be uncontroversial to the extent possible. Sometimes  developers have strong personal preferences with regard to some functionality, or any given design is unlikely to be the best one for most people. Such things should probably not be in Base.
 
 
## Quality considerations

Unison code in Base should meet some minimal quality standards.

### Efficiency

Code in Base should be reasonably efficient. At the very least, there should not be operations that take quadratic or exponential time where a linear or logarithmic time implementation is possible.

### License and author

Every term and type in Base should be [linked to at least one `Author` object](https://www.unisonweb.org/docs/configuration#setting-default-metadata-like-license-and-author) representing the person or organization who wrote the code. Every term and type in Base should also link to a permissive `License` that's compatible with the [MIT license](https://opensource.org/licenses/MIT).

If you don't want to retain copyright to your contribution, you can simply link to the [Unison license](https://share.unison-lang.org/latest/namespaces/unison/base/;/terms/metadata/licenses/unisoncomputing2021) as long as you state somewhere that you're assigning copyright for this code to Unison Computing. If that's what you're doing, simply comment on your pull request with something like the following:

> I'm the original author of this code and I'm assigning the copyright for it to Unison Computing.

If someone other than you is the original author, you should link to the code an `Author` object representing them, and also link the license under which you are republishing their code.

### Test coverage

Code in Base should have tests. [See here for a guide on how to write tests in Unison](https://www.unisonweb.org/docs/testing/). You should strive to have good test coverage before submitting your code as a pull request.

### Documentation

Everything added to Base needs to have good documentation in at least English. [See here for a guide to writing library documentation in Unison](https://www.unisonweb.org/docs/documentation/).

Docs should have proper spelling, grammar, and punctuation. They should be properly formatted so they look nice when rendered.

Docs should start with a brief one-paragraph overview, then optionally include a longer description. There should be code examples which illustrate common cases and edge cases. Finally, there should be links to related definitions and further reading.

See [the documentation of the `List` type](https://share.unison-lang.org/latest/types/unison/base/List) for an example of good documentation for a data type.

See [the documentation of `Natural.toDecimalText`](https://share.unison-lang.org/latest/namespaces/unison/base/;/terms/Natural/toDecimalText/doc) for an example of good function documentation.

## How to make a pull request to Base

This library follows the conventions in [this document](https://www.unisonweb.org/docs/codebase-organization/) and we recommend reading that document, in particular [this section on creating and managing pull requests](https://www.unisonweb.org/docs/codebase-organization/#day-to-day-development-creating-and-merging-pull-requests). 

The `base` library has no external dependencies, so its namespace looks like:

```
main/
  Int/
  Nat/
  ...

releases/
  _M1j/
  _M1k/
  ...
```

### Steps to making a PR

**1. Pull the `main` namespace from this repo into your local namespace:**

```
.> pull unison.public.base.main base
```

**2. It's a good idea to fork this to make your changes:**

```
.> fork base myTopic
```

**3. If you haven't already done so, set your default author,** and for at least `.myTopic` set the default license to `MIT`, which is the preferred license for new definitions in this repo (if you're already using the MIT license as your default license everywhere, then no action is needed). See [these instructions on how to configure your preferred licenses](https://www.unisonweb.org/docs/configuration/#setting-default-metadata-like-license-and-author). There's a sample excerpt config below.

**4. Now issue `namespace .myTopic` and hack away.** You can at any time review what's changed between your namespace and `.base` with `diff.namespace .base .myTopic`.

**5. Once you've made your changes, push your namespace to Share:**

```
.myTopic> push myUserName.public.base.main
```

**6. Use the `pull-request.create` command to create the PR:**

```
.myTopic> pr.create unison.public.base.main myUserName.public.base.main
```

This will generate some output. Copy that output to your clipboard. We don't literally use the GitHub pull request mechanism for Unison repositories, we use GitHub issues instead.

**7. [Create a GitHub __issue__](https://github.com/unisonweb/base/issues/new?template=unison-pull-request-template.md) in this repo** (that's right, an _issue_, __not__ a GitHub PR). Make the issue title something descriptive, and for the issue body, paste in the output generated by `pull-request.create` as well as some text describing the change in detail.

**8. Use the GitHub issue comments for coordinating the review.** Once merged, the maintainer will close the issue.

### Sample configuration

See [these instructions](https://www.unisonweb.org/docs/configuration/#setting-default-metadata-like-license-and-author) but to set the license for `prs.base`, your config will look something like:

```
DefaultMetadata = [".base.metadata.authors.myAuthorName",".metadata.licenses.myAuthorName_mit_2022"]
```

## Conventions used in this repository

For a definition (we'll use `List.map` as an example), here's where to put the documentation, tests, and examples:

* `List.map.doc` is the primary documentation. This make sure `docs List.map` knows where to find the docs.
  * `List.map.docs.whyListIsTheBest`, `List.map.docs.basicListProcessing` are any supporting documentation.
  * Suggestion: within the primary documentation, you can link to or transclude other documentation!
* `List.map.examples.ex1` or `List.map.examples.moreDescriptiveName` are examples (which might be used by the documentation).
* `List.map.tests.test1`, `List.map.tests.someBetterName` are named tests for `List.map`.

We put the docs, examples, and tests right next to the corresponding definitions for a couple of reasons:

* It plays well with [suffix-based name resolution](https://www.unisonweb.org/docs/language-reference/#suffix-based-name-resolution) since the tests, examples, and docs don't share a suffix with the original definition.
* It's a bit easier to do slicing and dicing of libraries when the definitions and their tests and examples are all together under a single namespace.

## Contributions that are most welcome

This isn't a complete list, but here are some ideas for contributions you can make:

* Documentation and/or tests or examples for existing definitions
* New definitions — like maybe add your favorite missing function on `List`
* Add a new data structure!
* Add some interesting functions that work with abilities. For instance, see the `Stream` namespace.

## Making changes to `base` later is not a big deal

Unlike other languages, where changing the standard library involves everyone downstream enduring a tedious upgrade cycle, definitions in Unison never change and are always valid once they are created. If we change the naming conventions or shuffle definitions around later, that's no big deal and doesn't break anyone's code. It's also not a problem for definitions to start out here in Base and perhaps later get broken out into separate libraries--none of the downstream code which obtained the definitions from here originally will break.

We hope this also means there's less need for [bikeshedding about small details](https://en.wikipedia.org/wiki/Law_of_triviality), because changing small things like naming and organization later is easy.
