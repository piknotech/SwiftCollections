# WeakSet

## Functionality

A `WeakSet` is a set holding weak references onto its elements. It is e. g. useful for delegation patterns, where you would want to add listeners to a set but don't want the set to keep references when nothing else references the items anymore. Its implementation is very similar to `WeakArray`.

## Implementation

A `WeakSet` is a collection with AnyObject conforming to Hashable as its contained element. It conforms to
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,

Internally, `WeakSet` stores a `Set` of `Weak<Element>` objects. Its contents can only be accessed via the `contents` property, which returns a `Set` of the currently non-nil contained items. This enables use of Swift-implemented methods on the `Set` type, like those implemented by conformance to `Collection` & `Sequence`.

Apart from everything implemented by the protocols it conforms to, `WeakSet` offers:
- methods to insert & remove members 
- a method to clean out all those `Weak<Element>` instances internally stored that wrap a value already being `nil`
- the `contents` property

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

If you don't call the add or remove functions, that auto-perform a clean, it may be suitable to call it manually from time to time for a large `WeakSet`.

```swift
weakSet.clean()  // Cleans out internal Weak<Element> instances whose contained value is nil
```

To access the `WeakSet`'s contents, you should use `contents`, which returns a `Set` of the contained elements. At this point you can use interfaces provided by the `Set` implementation of Swift.

```swift
print(weakSet.contents.isEmpty)  // Use of Collection protocol
print(weakSet.contents.first)  // Use of Collection protocol
for element in weakSet.contents { }  // Use of Sequence protocol
```
