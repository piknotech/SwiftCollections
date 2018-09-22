# WeakArrayWrapper

## Functionality

A `WeakArrayWrapper` is an array wrapper holding weak references onto its elements. It is e. g. useful for delegation patterns, where you would want to add listeners to an array but don't want the array to keep references when nothing else references the items anymore. Its implementation is very similar to `WeakSetWrapper`.

## Implementation

A `WeakArrayWrapper` is a generic type with `AnyObject` as its contained element. It conforms to
- `CustomStringConvertible`,
- `ExpressibleByArrayLiteral`,

Internally, `WeakArrayWrapper` stores an `Array` of `Weak<Element>` objects. Its contents can only be accessed via the `contents` property, which returns an `Array` of the currently non-nil contained items. This enables use of Swift-implemented methods on the `Array` type, like those implemented by conformance to `Collection` & `Sequence`.

Apart from everything implemented by the protocols it conforms to, `WeakArrayWrapper` offers:
- methods to add & remove members 
- a method to clean out all those `Weak<Element>` instances internally stored that wrap a value already being `nil`
- the `contents` property

## Use

You can create a `WeakArrayWrapper` using an array literal:

```swift
var weakArrayWrapper: WeakArrayWrapper<UIView> = [UIView(), UIView()]
```

To add an item, use `mutating func add(_ item: Element)`:

```swift
let myView = UIView()
weakArrayWrapper.add(myView)
```

To remove items that are referentially equal to the one provided as a parameter, use `mutating func removeIdentical(to item: Element)`:

```swift
weakArrayWrapper.removeIdentical(to: myView)
```

If you don't call the add or remove functions, that auto-perform a clean, it may be suitable to call it manually from time to time for a large `WeakArrayWrapper`.

```swift
weakArrayWrapper.clean()  // Cleans out internal Weak<Element> instances whose contained value is nil
```

To access the `WeakArrayWrapper`'s contents, you should use `contents`, which returns an `Array` of the contained elements. At this point you can use interfaces provided by the `Array` implementation of Swift.

```swift
print(weakArrayWrapper.contents.isEmpty)  // Use of Collection protocol
print(weakArrayWrapper.contents.first)  // Use of Collection protocol
for element in weakArrayWrapper.contents { }  // Use of Sequence protocol
```
