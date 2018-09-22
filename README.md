<p align="center">
    <img src="https://raw.githubusercontent.com/piknotech/SwiftCollections/stable/Logo.png" width=600>
</p>

<p align="center">
    <a href="https://travis-ci.org/piknotech/SwiftCollections">
        <img src="https://travis-ci.org/piknotech/SwiftCollections.svg?branch=stable" alt="Build Status">
    </a>
    <a href="#">
        <img src="https://img.shields.io/badge/swift-4.2-FFAC45.svg" alt="Swift: 4.2">
    </a>
    <a href="https://github.com/piknotech/SwiftCollections/releases">
        <img src="https://img.shields.io/badge/version-1.0-blue.svg"
        alt="Version: 1.0">
    </a>
    <a href="https://github.com/piknotech/SwiftCollections/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT-lightgrey.svg" alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#documentation">Documentation</a>
  • <a href="https://github.com/piknotech/SwiftCollections/issues">Issues</a>
  • <a href="https://github.com/piknotech/SwiftCollections/pulls">Pull Requests</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>

*SwiftCollections* is a collection of handy, custom-written Swift collection types.

Not all of the collections in this repo are useful in every project, so this is rather a library of types being suitable for specific tasks. For the sake of being able to build & test it, the files are nonetheless wrapped together as a static cocoa touch library of no further use.

## Documentation

In this repo, a collection is not considered a type that has to conform to the `Collection` protocol, but anything that collects any type in any way. However, collecting must be the main purpose of the type, so a `UIViewController` subclass with two arrays collecting `String` e. g. wouldn't properly fit into this scheme. For an example, where a collection in the terminology of this repo doesn't conform to the `Collection` protocol, but has the main purpose of collecting something, see `WeakArrayWrapper`.

This repo has a fixed file and folder structure:

In the *Collections* folder, each collection has another subfolder. Within this subfolder are two files:
- The **Swift Source File** implementing the custom collection. Its name equals the name of the collection implemented as well as the containing folder.
- A **Documentation File**, documenting this specific collection. Its name is the containing folders name followed by the suffix "Doc". The extent of this file depends on the collection it documents, but it will always be there at least.

In the *Helpers* folder, helper types / extensions that may be needed for collection implementations are stored. Those aren't part of the collection's folder itself since helpers may be needed for multiple collections at once. Very tiny helpers that are only needed for one specific collection, may be added in the implementation file itself.

For documentation on a specific collection, see its corresponding doc file.

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](https://github.com/piknotech/SwiftCollections/blob/stable/CONTRIBUTING.md) for in-depth information.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See [LICENSE.md](https://github.com/piknotech/SwiftCollections/blob/stable/LICENSE.md) for details.
