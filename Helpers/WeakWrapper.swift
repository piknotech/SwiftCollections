//
//  WeakWrapper.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

/// WeakWrapper wrapper for generic AnyObject.
final class WeakWrapper<T>: Hashable where T: AnyObject {
    // MARK: - Properties
    let hashValue: Int
    private(set) weak var value: T?

    // MARK: - Initializers
    init(_ value: T) {
        self.value = value
        hashValue = ObjectIdentifier(value).hashValue
    }

    // MARK: - Methods
    static func == (lhs: WeakWrapper, rhs: WeakWrapper) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
