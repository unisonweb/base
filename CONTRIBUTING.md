# Contributing to the Unison Base libraries

Hi. 😀 We welcome you to contribute to the Unison base libraries.

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
trunk/
  List/
  Nat/

releases/
  _M1j/
  _M1k/
  ...
```

You should pull `trunk` of this repo into your local namespace, forking it to make some changes, pushing the updated version of trunk to some public Unison repo, then using the `pull-request.create` command to create the PR.

### Steps

1. `.> pull https://github.com/unisonweb/base:.trunk ._base` (you can do this both for initial fetch and for subsequent updates)
2. `.> fork ._base .prs.base._mything` to create a copy of `_base`. You can create multiple forks in `.prs.base`, if you have multiple things you're working on.
3. If you haven't already done so, set your default author, and for at least `.prs.base` set the default license to MIT, which is the preferred license for new definitions in this repo (if you're already using the MIT license as your default license everywhere, then no action needed). See [these instructions on how to configure just a sub-namespace with a different license](https://www.unisonweb.org/docs/configuration/#setting-default-metadata-like-license-and-author) and there's a sample excerpt config below.
4. Now `cd .prs.base._mything` and hack away. You can at any time review what's changed between your namespace and `_base` with `diff.namespace ._base .prs.base._mything`.
5. Push your forked version somewhere public. Suggestion: just mirror your root Unison namespace to a git repo `.> push git@github.com:mygithubname/allmyunisoncode`. No need to maintain a separate Git repo for every Unison library you want to contribute to.
6. `.prs.base._mything> pull-request.create https://github.com/unisonweb/base:.trunk https://github.com/myuser/allmyunisoncode:.prs.base._mything` and this will create some output. Copy that output to your clipboard. We don't literally use the GitHub pull request mechanism for Unison repositories, we use GitHub issues instead.
7. Next, [create a GitHub __issue__](https://github.com/unisonweb/base/issues/new?template=unison-pull-request-template.md) in this repo (that's right, an _issue_, __not__ a GitHub PR). Make the issue title something descriptive, and for the issue body, paste in the output generated by `pull-request.create` as well as some text describing the change, just like you would for any other pull request.
8. Use the GitHub issue comments for coordinating the review. Once merged, the maintainer will close the issue.

### Sample configuration

See [these instructions](https://www.unisonweb.org/docs/configuration/#setting-default-metadata-like-license-and-author) but to set the license for `prs.base`, your config will look something like:

```
DefaultMetadata {
  prs.base = [".metadata.licenses.myauthorname_mit_2020"]
}
```

## Conventions used in this repository

For a definition (we'll use `List.map` as an example), here's where to put the documentation, tests, and examples:

* `List.map.doc` is the primary documentation. It should be linked to `List.map` using the `link` command [as described here](https://www.unisonweb.org/docs/documentation). This ensures that the user can view these docs using `docs List.map`.
  * `List.map.docs.whyListIsTheBest`, `List.map.docs.basicListProcessing` are any supporting documentation.
  * Suggestion: within the primary documentation, you can link to other documentation!
* `List.map.examples.ex1` or `List.map.examples.moreDescriptiveName` are examples (which might be used by the documentation).
* `List.map.tests.ex1`, `List.map.tests.someBetterName` are named tests for `List.map`.

We put the docs, examples, and tests right next to the corresponding definitions for a couple of reasons:

* It plays well with [suffix-based name resolution](https://www.unisonweb.org/docs/language-reference/#suffix-based-name-resolution) since the tests, examples, and docs don't share a suffix with the original definition.
* It's a bit easier to do slicing and dicing of libraries when the definitions and their tests and examples are all together under a single namespace.

## Contributions that are most welcome

This isn't a complete list, but here are some ideas for contributions you can make:

* Documentation and/or tests or examples for existing definitions
* New definitions... like maybe add your favorite missing function on `List`
* Add a new data structure!
* Add some interesting functions that work with abilities. For instance, see the `Stream` namespace.

## Making changes to `base` later is not a big deal

Unlike other languages, where changing the standard library involves everyone downstream enduring a tedious upgrade cycle, definitions in Unison never change and are always valid once they are created. If we change the naming conventions or shuffle definitions around later, that's no big deal and doesn't break anyone's code. It's also not a problem for definitions to start out here in base and perhaps later get broken out into separate libraries--none of the downstream code which obtained the definitions from here originally will break.

We hope this also means there's less need for [bikeshedding about small details](https://en.wikipedia.org/wiki/Law_of_triviality), because changing small things like naming and organization later is easy.

## Known issues

### Tests and docs can't go under operators

At this time, there is a restriction on having *operators* be part of namespaces. To circumvent this limitation, after creating your function and adding [documentation](https://www.unisonweb.org/docs/documentation/) and examples, **alias** the function with the operator name of your choice.
```
inc : Nat -> Nat
inc x = x + 1

inc.doc = [:
  `inc` increments a Nat.
  It exists as a workaround for the `++` operator.
:]
```
Then in the codemanager:
```
.> link inc.doc inc

  Updates:
  
    1. inc : Nat -> Nat
       + 2. doc : Doc
.> alias.term inc .some.namespace.(++)

  Done.
```

### It's currently annoying to update documentation that's already been linked to definitions

Currently, if you've already linked documentation to a definition, updating that documentation doesn't unlink the old docs and link in the new version, so you have to do that manually. Not great. See [this issue](https://github.com/unisonweb/unison/issues/1497).

Until this issue is fixed, you might want to hold off on linking documentation to the definitions until you're pretty happy with it.
