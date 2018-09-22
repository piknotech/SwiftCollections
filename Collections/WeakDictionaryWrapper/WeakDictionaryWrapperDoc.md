# WeakDictionaryWrapper

## Functionality

A `WeakDictionaryWrapper` is a dictionary holding weak references onto its values. It may be useful in similar areas as `WeakArrayWrapper` or `WeakSetWrapper`: Everywhere, where only weak references to the dictionary values should be kept, so if the retain count of a value stored in the dictionary becomes zero, the value for the corresponding key gets removed.

## Implementation

A `WeakDictionaryWrapper` is a generic type with `Key` conforming to `Hashable` and `Value` conforming to `AnyObject`. Itself, it conforms to
- `CustomStringConvertible`,
- `ExpressibleByDictionaryLiteral`,

Internally, `WeakDictionaryWrapper` stores a `Dictionary` with the values wrapped as `Weak<Value>`. Its contents can be accessed either via a `subscript` getter or the `contents` property, which returns a `Dictionary` with those key-value-pairs whose value is currently non-nil. This enables use of Swift-implemented methods on the `Dictionary` type.

Apart from everything implemented by the protocols it conforms to, `WeakDictionaryWrapper` offers:
- a subscript to `get` and `set` values for a key
- a method to clean out all those `Weak<Element>` instances internally stored that wrap a value already being `nil`
- the `contents` property

## Use

You can create a `WeakDictionaryWrapper` using a dictionary literal:

```swift
var weakDictionaryWrapper: WeakDictionaryWrapper<String: UIView> = ["test1": UIView(), "test2": UIView()]
```

To set a value for a key, use a `subscript` setter:

```swift
let myView = UIView()
weakDictionaryWrapper["test3"] = myView
```

To remove a value for a key, use a `subscript` setter with the value being `nil`:

```swift
weakDictionaryWrapper["test3"] = nil
```

If you don't call the `subscript` setter, that auto-performs a clean, it may be suitable to call it manually from time to time for a large `WeakDictionaryWrapper`.

```swift
weakDictionaryWrapper.clean()  // Cleans out internal Weak<Element> instances whose contained value is nil
```

To get the value for a key, you can use a `subscript` getter:

```swift
weakDictionaryWrapper["test3"]  // Returns nil for this configuration
```

To access the `WeakDictionaryWrapper`'s contents apart from the simple getter, you should use `contents`, which returns a dicionary of those key-value-pairs where the value isn't `nil`. At this point you can use interfaces provided by the `Dictionary` implementation of Swift.

```swift
print(weakDictionaryWrapper.keys)
print(weakDictionaryWrapper.values)
print(weakDictionaryWrapper.count)
```
