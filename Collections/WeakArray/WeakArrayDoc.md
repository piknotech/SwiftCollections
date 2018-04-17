# WeakArray

## Functionality

A `WeakArray` is an array holding weak references onto its elements. It is e. g. useful for delegation patterns, where you would want to add listeners to an array but don't want the array to keep references when nothing else references the items anymore. Its implementation is very similar to `WeakSet`.

## Implementation

A `WeakArray` is a collection with AnyObject as its contained element. It conforms to
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,

Internally, `WeakArray` stores an `Array` of `Weak<Element>` objects. Its contents can only be accessed via the `contents` property, which returns an `Array` of the currently non-nil contained items. This enables use of Swift-implemented methods on the `Array` type, like those implemented by conformance to `Collection` & `Sequence`.

Apart from everything implemented by the protocols it conforms to, `WeakArray` offers:
- methods to add & remove members 
- a method to clean out all those `Weak<Element>` instances internally stored that wrap a value already being `nil`
- the `contents` property

## Use

You can create a `WeakArray` using an array literal:

```swift
var weakArray: WeakArray<UIView> = [UIView(), UIView()]
```

To add an item, use `mutating func add(_ item: Element)`:

```swift
let myView = UIView()
weakArray.add(myView)
```

To remove items that are referentially equal to the one provided as a parameter, use `mutating func removeIdentical(to item: Element)`:

```swift
weakArray.removeIdentical(to: myView)
```

If you don't call the add or remove functions, that auto-perform a clean, it may be suitable to call it manually from time to time for a large `WeakArray`.

```swift
weakArray.clean()  // Cleans out internal Weak<Element> instances whose contained value is nil
```

To access the `WeakArray`'s contents, you should use `contents`, which returns an `Array` of the contained elements. At this point you can use interfaces provided by the `Array` implementation of Swift.

```swift
print(weakArray.contents.isEmpty)  // Use of Collection protocol
print(weakArray.contents.first)  // Use of Collection protocol
for element in weakArray.contents { }  // Use of Sequence protocol
```
