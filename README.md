# SwiftCollections
*SwiftCollections* is collection of handy, custom-written Swift collections. Not all of them are useful in every project, so this is rather a library of custom collections that may be suitable for specific tasks.

## Documentation

In this repo, a collection is not considered a type that has to conform to the `Collection` protocol, but anything that collects something. For an example, where a collection in the terminology of this repo doesn't conform to the `Collection` protocol, see `WeakArray`.

This repo has a fixed file and folder structure:

In the *Collections* folder, each collection has another subfolder. Within this subfolder are two files:
- The **Swift Source File** implementing the custom collection. Its name equals the name of the collection implemented as well as the containing folder.
- A **Documentation File**, documenting this specific collection. Its name is the containing folders name followed by the suffix "Doc". The extent of this file depends on the collection it documents, but it will always be there at least.

In the *Helpers* folder, helper types / extensions that may be needed for collection implementations are stored. Those aren't part of the collection's folder itself since helpers may be needed for multiple collections at once. Very tiny helpers that are only needed for one specific collection, may be added in the implementation file itself.

For documentation on a specific collection, see its corresponding doc file.

## Contributing

Contributions are welcome. In fact, this repository lives from creative proposals on how to make use of the ability to create custom collections.

If you don't know how to create custom collections, but want to learn about it, I suggest [this tutorial](https://www.raywenderlich.com/139591/building-custom-collection-swift).

If you want to add a new collection, just open up a pull request. Please stick to the file structure described above:
- In the *Collections* folder, add a new folder named the same as your collection.
- In the newly created folder, add the collection source file and a doc file. Please use the [DocTemplate.md](https://github.com/fredpi/SwiftCollections/blob/stable/DocTemplate.md) file at the root of this repository as a template for any documentation file and keep its structure as far as possible.
- Add any helper types or extensions in the *Helpers* folder.

Please also respect these guidelines:
- For **commit messages**, follow the syntax described [here](http://chris.beams.io/posts/git-commit/).
- For **new files or additions**, follow the file structure guide described [here](http://bestpractices.jamitlabs.com/t/file-structure-use-of-mark/84).

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See [LICENSE.md](https://github.com/fredpi/SwiftCollections/blob/stable/LICENSE.md) for details.
