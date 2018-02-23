//
//  WeakSet.swift
//

import Foundation

struct WeakSet<Element>: CustomStringConvertible, ExpressibleByArrayLiteral where Element: AnyObject, Element: Hashable {
    // MARK: - Properties
    var isEmpty: Bool {
        return contents.isEmpty
    }

    var description: String {
        return "\(contents.count) Item(s): \(String(describing: contents))"
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

    init(arrayLiteral elements: Element...) {
        self.init(elements)
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
