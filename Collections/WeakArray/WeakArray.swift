//
//  WeakArray.swift
//

struct WeakArray<Element>: CustomStringConvertible, ExpressibleByArrayLiteral where Element: AnyObject {
    // MARK: - Properties
    var isEmpty: Bool {
        return contents.isEmpty
    }

    var description: String {
        return "\(contents.count) Item(s): \(String(describing: contents))"
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

    init(arrayLiteral elements: Element...) {
        self.init(elements)
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
