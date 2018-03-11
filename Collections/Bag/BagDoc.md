# Bag

## Functionality

A `Bag` is a collection type that counts the occurences of a specific value in it. It's based on a dictionary, but simplifies things so the user doesn't have to perform the logic itself.

## Implementation

The `Bag` collection is a collection with `Hashable` as the contained element. It conforms to
- `Sequence`,
- `Collection`
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,
- `ExpressibleByDictionaryLiteral`

Apart from everything implemented by these protocols, `Bag` offers:`
- subscripting to a specific key
- methods to add members and remove members
- properties to read unique count, unique elements, total count and total elements

## Use

You can create a Bag with an array literal or a dictionary literal:

```swift
var bag: Bag<String> = ["A", "A", "B", "C"]
// or
var bag: Bag<String> = ["A": 2, "B": 1, "C": 1]
```

You can add members to the Bag using `mutating func add(_ member: ContainedElement, occurrences: Int = 1)`:

```swift
bag.add("D", occurences: 5)
```

You can remove members from the Bag using `mutating func remove(_ removalType: RemovalType, of element: ContainedElement)`:

```swift
bag.remove(.any(2), of: "D")
bag.remove(.all, of: "A")
```

You can use a subscript to get the current item count of a member:

```swift
print(bag["A"]) // Returns 2 for the current example
```

Use `uniqueCount` and `totalCount` for getting the content count:

```swift
var newBag = ["A", "A", "B"]
print(newBag.uniqueCount) // Prints 2
print(newBag.totalCount) // Prints 3
```

Use `uniqueElements` and `totalElements` for getting the contents:

```swift
var newBag = ["A", "A", "B"]
print(newBag.uniqueElements) // Prints ["A, "B"]
print(newBag.totalElements) // Prints ["A, "A", "B"]
```

The methods provided by `Collection` and `Sequence` are available just like you're used to it.

## License

This code is taken from [https://github.com/ecerney/Bag](https://github.com/ecerney/Bag), released under the MIT license. It's slightly modified.
