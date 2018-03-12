# SwiftCollections

*SwiftCollections* is collection of handy, custom-written Swift collections. Not all of them are useful in every project, so this is rather a library of custom collections that may be suitable for specific tasks. For the sake of being able to build & test it, the files are nonetheless wrapped together as a static cocoa touch library of no further use.

## Documentation

In this repo, a collection is not considered a type that has to conform to the `Collection` protocol, but anything that collects something. For an example, where a collection in the terminology of this repo doesn't conform to the `Collection` protocol, see `WeakArray`.

This repo has a fixed file and folder structure:

In the *Collections* folder, each collection has another subfolder. Within this subfolder are two files:
- The **Swift Source File** implementing the custom collection. Its name equals the name of the collection implemented as well as the containing folder.
- A **Documentation File**, documenting this specific collection. Its name is the containing folders name followed by the suffix "Doc". The extent of this file depends on the collection it documents, but it will always be there at least.

In the *Helpers* folder, helper types / extensions that may be needed for collection implementations are stored. Those aren't part of the collection's folder itself since helpers may be needed for multiple collections at once. Very tiny helpers that are only needed for one specific collection, may be added in the implementation file itself.

For documentation on a specific collection, see its corresponding doc file.

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](https://github.com/fredpi/SwiftCollections/blob/stable/CONTRIBUTING.md) for in-depth information.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See [LICENSE.md](https://github.com/fredpi/SwiftCollections/blob/stable/LICENSE.md) for details.
