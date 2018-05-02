//
//  Weak.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

/// Weak wrapper for generic AnyObject.
final class Weak<T>: Hashable where T: AnyObject {
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
