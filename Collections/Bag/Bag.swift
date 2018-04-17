//
//  Bag.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

struct Bag<ContainedElement: Hashable> {
    // MARK: - Subtypes
    enum RemovalType {
        case any(Int)
        case all
    }

    // MARK: - Properties
    var uniqueCount: Int {
        return contents.count
    }

    var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }

    var uniqueElements: [ContainedElement] {
        return contents.map { $0.0 }
    }

    var totalElements: [ContainedElement] {
        var array = [ContainedElement]()
        contents.forEach { arg in
            let (element, count) = arg
            (0..<count).forEach { _ in array.append(element) }
        }

        return array
    }

    private var contents: [ContainedElement: Int] = [:]

    // MARK: - Initializers
    init() { }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == ContainedElement {
        for element in sequence {
            add(element)
        }
    }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: ContainedElement, value: Int) {
        for (element, count) in sequence {
            add(element, occurrences: count)
        }
    }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (element: ContainedElement, count: Int) {
        for (element, count) in sequence {
            add(element, occurrences: count)
        }
    }

    // MARK: - Methods
    subscript (item: ContainedElement) -> Int {
        return contents[item] ?? 0
    }

    mutating func add(_ member: ContainedElement, occurrences: Int = 1) {
        precondition(occurrences > 0, "Can only add a positive number of occurrences")

        if let currentCount = contents[member] {
            contents[member] = currentCount + occurrences
        } else {
            contents[member] = occurrences
        }
    }

    /// Removes occurrences times the specific member, or remove all occurrences.
    /// The number of occurrences must be positive and must not be greater
    /// than the current count of the specified element.
    mutating func remove(_ removalType: RemovalType, of element: ContainedElement) {
        switch removalType {
        case .any(let occurences):
            precondition(occurences >= 0, "Can only remove a positive number of occurrences")

            let currentCount = contents[element] ?? 0
            precondition(
                occurences <= currentCount,
                "Can only remove as much occurrences as the element exists in the collection"
            )

            // Remove or update element
            if currentCount == occurences {
                contents.removeValue(forKey: element)
            } else {
                contents[element] = currentCount - occurences
            }

        case .all:
            contents.removeValue(forKey: element)
        }
    }
}

// MARK: - CustomStringConvertible
extension Bag: CustomStringConvertible {
    var description: String {
        return "Bag<\(String(describing: contents))>"
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Bag: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: ContainedElement...) {
        self.init(elements)
    }
}

// MARK: - ExpressibleByDictionaryLiteral
extension Bag: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (ContainedElement, Int)...) {
        // The map converts elements to the "named" tuple the initializer expects.
        self.init(elements.map { (key: $0.0, value: $0.1) })
    }
}

// MARK: - Sequence
extension Bag: Sequence {
    typealias Iterator = AnyIterator<(element: ContainedElement, count: Int)>

    func makeIterator() -> Iterator {
        var iterator = contents.makeIterator()
        return AnyIterator {
            return iterator.next()
        }
    }
}

// MARK: - Collection
extension Bag: Collection {
    typealias Index = BagIndex<ContainedElement>

    var startIndex: Index {
        return BagIndex(contents.startIndex)
    }

    var endIndex: Index {
        return BagIndex(contents.endIndex)
    }

    subscript (position: Index) -> Iterator.Element {
        precondition((startIndex ..< endIndex).contains(position), "Out of bounds")
        let dictionaryElement = contents[position.index]
        return (element: dictionaryElement.key, count: dictionaryElement.value)
    }

    func index(after index: Index) -> Index {
        return Index(contents.index(after: index.index))
    }
}

// MARK: - Equatable
extension Bag: Equatable {
    static func == (lhs: Bag, rhs: Bag) -> Bool {
        return lhs.contents == rhs.contents
    }
}

// MARK: - BagIndex
struct BagIndex<Element: Hashable> {
    fileprivate let index: DictionaryIndex<Element, Int>

    fileprivate init(_ dictionaryIndex: DictionaryIndex<Element, Int>) {
        self.index = dictionaryIndex
    }
}

extension BagIndex: Comparable {
    static func == (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index == rhs.index
    }

    static func < (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index < rhs.index
    }
}
