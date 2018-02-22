//
//  WeakSet.swift
//

import Foundation

/// WeakSet holding weak references onto its elements.
/// Conforms to Sequence to make iterating possible.
/// Doesn't conform to Collection since accessing indices e. g. doesn't make sense when nil-values may get filtered out.
struct WeakSet<Element>: CustomStringConvertible, ExpressibleByArrayLiteral, Sequence where Element: AnyObject, Element: Hashable {
    // MARK: - Properties
    var isEmpty: Bool {
        return contentValues.isEmpty
    }

    var description: String {
        return "\(contentValues.count) Item(s): \(String(describing: contentValues))"
    }

    private var contents = Set<Weak<Element>>()
    private var contentValues: Set<Element> {
        return Set(contents.flatMap { $0.value })
    }

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
    func makeIterator() -> AnyIterator<Element> {
        return AnyIterator(contents.map { $0.value }.flatMap { $0 }.makeIterator())
    }

    mutating func insert(_ item: Element) {
        clean()
        contents.insert(Weak<Element>(item))
    }

    mutating func remove(_ item: Element) {
        clean()
        contents.remove(Weak<Element>(item))
    }

    mutating func clean() {
        contents = contents.filter { $0.value != nil }
    }
}
