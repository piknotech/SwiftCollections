# WeakArray

## Functionality

A `WeakArray` is an array holding weak references onto its elements. It is e. g. useful for delegation patterns, where you would want to add listeners to an array but don't want the array to keep references when nothing else references the items anymore. Its implementatipn is very similar to `WeakSet`.

## Implementation

A `WeakArray` is a collection with AnyObject as its contained element. It conforms to
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,

It doesn't conform to `Sequence` and `Collection`. Internally `WeakArray` stores an array of `Weak<Element>` objects, but only regards those objects, whose contained value is not nil. The value of the weak array might change all of a sudden (as soon as the reference count of any contained value equals 0), therefore, working with indices (`Collection` protocol) or iterating (`Sequence` protocol) doesn't make sense. However, once the variable `contents` is accessed, an array of the currently non-nil contained item is returned which enables use of `Collection` & `Sequence`.

Apart from everything implemented by the protocols, `WeakArray` offers:
- methods to add members, remove members and clean out `Weak<Element>` instances internally stored, but with out a non-nil contained value.
- an emptyness check & content property.

## Use

You can create a `WeakArray` using an array literal:

```
var weakArray: WeakArray<UIView> = [UIView(), UIView()]
```

To add an item, use `mutating func add(_ item: Element)`:

```
let myView = UIView()
weakArray.add(myView)
```

To remove items that are referentially equal to the one provided as a parameter, use `mutating func removeIdentical(to item: Element)`:

```
weakArray.removeIdentical(to: myView)
```

If you don't call the add or remove functions, that auto-perform a clean, it may be suitable, to call it manually from time to time for a large `WeakArray`.

```
weakArray.clean() // Cleans out internal Weak<Element> instances whose contained value is nil
```

To access the weakArray's contents, you should use `contents` which returns an array of the contained elements. At this point, you can use interfaces provided by `Collection` or `Sequence`. For a simple emptyness check you can still use `isEmpty` on the original collection, without accessing `contents`:

```
print(weakArray.isEmpty) // Same as weakArray.contents.isEmpty
print(weakArray.contents.first) // Use of Collection protocol
for element in weakArray.contents { } // Use of Sequence protocol
```
