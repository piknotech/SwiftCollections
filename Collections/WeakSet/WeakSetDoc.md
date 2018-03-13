# WeakSet

## Functionality

A `WeakSet` is a set holding weak references onto its elements. It is e. g. useful for delegation patterns, where you would want to add listeners to a set but don't want the set to keep references when nothing else references the items anymore. Its implementatipn is very similar to `WeakArray`.

## Implementation

A `WeakSet` is a collection with AnyObject conforming to Hashable as its contained element. It conforms to
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,

It doesn't conform to `Sequence` and `Collection`. Internally `WeakSet` stores a set of `Weak<Element>` objects, but only regards those objects, whose contained value is not nil. The value of the weak set might change all of a sudden (as soon as the reference count of any contained value equals 0), therefore, working with indices (`Collection` protocol) or iterating (`Sequence` protocol) doesn't make sense. However, once the variable `contents` is accessed, a set of the currently non-nil contained item is returned which enables use of `Collection` & `Sequence`.

Apart from everything implemented by the protocols, `WeakSet` offers:
- methods to add members, remove members and clean out `Weak<Element>` instances internally stored, but with out a non-nil contained value.
- an emptyness check & content property.

## Use

You can create a `WeakSet` using an array literal:

```swift
var weakSet: WeakSet<UIView> = [UIView(), UIView()]
```

To add an item, use `mutating func add(_ item: Element)`:

```swift
let myView = UIView()
weakSet.add(myView)
```

To remove items, use `mutating func remove(_ item: Element)`:

```swift
weakSet.remove(myView)
```

If you don't call the add or remove functions, that auto-perform a clean, it may be suitable, to call it manually from time to time for a large `WeakSet`.

```swift
weakSet.clean() // Cleans out internal Weak<Element> instances whose contained value is nil
```

To access the `WeakSet`'s contents, you should use `contents` which returns a set of the contained elements. At this point, you can use interfaces provided by `Collection` or `Sequence`:

```swift
print(weakSet.contents.isEmpty) // Use of Collection protocol
print(weakSet.contents.first) // Use of Collection protocol
for element in weakSet.contents { } // Use of Sequence protocol
```
