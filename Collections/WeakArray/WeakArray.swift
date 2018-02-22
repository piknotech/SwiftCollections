//
//  WeakArray.swift
//

import Foundation

/// WeakArray holding weak references onto its elements.
/// Conforms to Sequence to make iterating possible.
/// Doesn't conform to Collection since accessing indices e. g. doesn't make sense when nil-values may get filtered out.
struct WeakArray<Element>: CustomStringConvertible, ExpressibleByArrayLiteral, Sequence where Element: AnyObject {
    // MARK: - Properties
    var isEmpty: Bool {
        return contentValues.isEmpty
    }

    var description: String {
        return "\(contentValues.count) Item(s): \(String(describing: contentValues))"
    }

    private var contents = [Weak<Element>]()
    private var contentValues: [Element] {
        return contents.flatMap { $0.value }
    }

    // MARK: - Initializers
    init() { }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            add(element)
        }
    }

    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }

    // MARK: - Methods
    func makeIterator() -> AnyIterator<Element> {
        return AnyIterator(contents.map { $0.value }.flatMap { $0 }.makeIterator())
    }

    mutating func add(_ item: Element) {
        clean()
        contents.append(Weak<Element>(item))
    }

    mutating func removeIdentical(to item: Element) {
        clean()
        contents = contents.filter { $0.value !== item }
    }

    mutating func clean() {
        contents = contents.filter { $0.value != nil }
    }
}
