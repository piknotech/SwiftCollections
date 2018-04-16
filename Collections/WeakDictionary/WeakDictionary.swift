//
//  WeakDictionary.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

struct WeakDictionary<Key: Hashable, Value: Hashable> where Value: AnyObject {
    // MARK: - Properties
    var contents: [Key: Value] {
        return wrappedContents.filter { $0.value.value != nil }.mapValues { $0.value! }
    }

    private var wrappedContents = [Key: Weak<Value>]()

    // MARK: - Initializers
    init() { }

    init(_ dictionary: [Key: Value]) {
        dictionary.forEach { key, value in
            wrappedContents[key] = Weak(value)
        }
    }

    // MARK: - Subscripts
    subscript(key: Key) -> Value? {
        get {
            return wrappedContents[key]?.value
        }

        set(newValue) {
            wrappedContents[key] = newValue.map(Weak.init)
        }
    }

    mutating func clean() {
        wrappedContents = wrappedContents.filter { $0.value.value != nil }
    }
}

// MARK: - CustomStringConvertible
extension WeakDictionary: CustomStringConvertible {
    var description: String {
        return "WeakDictionary<\(String(describing: contents))>"
    }
}

// MARK: - ExpressibleByDictionaryLiteral
extension WeakDictionary: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Key, Value)...) {
        self.init() // TODO
    }
}
