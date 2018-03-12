//
//  WeakSet.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Released as a part of SwiftCollections. https://www.github.com/fredpi/SwiftCollections
//

import Foundation

struct WeakSet<Element> where Element: AnyObject, Element: Hashable {
    // MARK: - Properties
    var isEmpty: Bool {
        return contents.isEmpty
    }

    var contents: Set<Element> {
        return Set(wrappedContents.flatMap { $0.value })
    }

    private var wrappedContents = Set<Weak<Element>>()

    // MARK: - Initializers
    init() { }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            insert(element)
        }
    }

    // MARK: - Methods
    mutating func insert(_ item: Element) {
        clean()
        wrappedContents.insert(Weak<Element>(item))
    }

    mutating func remove(_ item: Element) {
        clean()
        wrappedContents.remove(Weak<Element>(item))
    }

    mutating func clean() {
        wrappedContents = wrappedContents.filter { $0.value != nil }
    }
}

// MARK: - CustomStringConvertible
extension WeakSet: CustomStringConvertible {
    var description: String {
        return "\(contents.count) Item(s): \(String(describing: contents))"
    }
}

// MARK: - ExpressibleByArrayLiteral
extension WeakSet: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
