//
//  WeakArrayWrapper.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

struct WeakArrayWrapper<Element: AnyObject> {
    // MARK: - Properties
    var contents: [Element] {
        return wrappedContents.compactMap { $0.value }
    }

    private var wrappedContents = [WeakWrapper<Element>]()

    // MARK: - Initializers
    init() { }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            add(element)
        }
    }

    // MARK: - Methods
    mutating func add(_ item: Element) {
        clean()
        wrappedContents.append(WeakWrapper<Element>(item))
    }

    mutating func removeIdentical(to item: Element) {
        clean()
        wrappedContents = wrappedContents.filter { $0.value !== item }
    }

    mutating func clean() {
        wrappedContents = wrappedContents.filter { $0.value != nil }
    }
}

// MARK: - CustomStringConvertible
extension WeakArrayWrapper: CustomStringConvertible {
    var description: String {
        return "WeakArrayWrapper<\(String(describing: contents))>"
    }
}

// MARK: - ExpressibleByArrayLiteral
extension WeakArrayWrapper: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
