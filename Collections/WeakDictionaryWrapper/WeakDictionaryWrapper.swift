//
//  WeakDictionaryWrapper.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

struct WeakDictionaryWrapper<Key: Hashable, Value: AnyObject> {
    // MARK: - Properties
    var contents: [Key: Value] {
        return wrappedContents.filter { $0.value.value != nil }.mapValues { $0.value! }
    }

    private var wrappedContents = [Key: WeakWrapper<Value>]()

    // MARK: - Initializers
    init() { }

    init(_ dictionary: [Key: Value]) {
        dictionary.forEach { key, value in
            wrappedContents[key] = WeakWrapper(value)
        }
    }

    // MARK: - Subscripts
    subscript(key: Key) -> Value? {
        get {
            return wrappedContents[key]?.value
        }

        set(newValue) {
            clean()
            wrappedContents[key] = newValue.map(WeakWrapper.init)
        }
    }

    mutating func clean() {
        wrappedContents = wrappedContents.filter { $0.value.value != nil }
    }
}

// MARK: - CustomStringConvertible
extension WeakDictionaryWrapper: CustomStringConvertible {
    var description: String {
        return "WeakDictionaryWrapper<\(String(describing: contents))>"
    }
}

// MARK: - ExpressibleByDictionaryLiteral
extension WeakDictionaryWrapper: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Key, Value)...) {
        self.init() // TODO
    }
}
