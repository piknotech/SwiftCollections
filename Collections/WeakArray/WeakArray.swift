//
//  WeakArray.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Released as a part of SwiftCollections. https://www.github.com/fredpi/SwiftCollections
//

struct WeakArray<Element> where Element: AnyObject {
    // MARK: - Properties
    var isEmpty: Bool {
        return contents.isEmpty
    }

    var contents: [Element] {
        return wrappedContents.flatMap { $0.value }
    }

    private var wrappedContents = [Weak<Element>]()

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
        wrappedContents.append(Weak<Element>(item))
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
extension WeakArray: CustomStringConvertible {
    var description: String {
        return "\(contents.count) Item(s): \(String(describing: contents))"
    }
}

// MARK: - ExpressibleByArrayLiteral
extension WeakArray: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
