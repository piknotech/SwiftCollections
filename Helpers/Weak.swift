//
//  Weak.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Released as a part of SwiftCollections. https://www.github.com/fredpi/SwiftCollections
//

import Foundation

/// Weak wrapper for generic AnyObject.
class Weak<T>: Hashable where T: AnyObject {
    // MARK: - Properties
    let hashValue: Int
    private(set) weak var value: T?

    // MARK: - Initializers
    init(_ value: T) {
        self.value = value
        hashValue = ObjectIdentifier(value).hashValue
    }

    // MARK: - Methods
    static func == (lhs: Weak, rhs: Weak) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
