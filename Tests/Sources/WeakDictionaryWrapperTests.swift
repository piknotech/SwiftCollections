//
//  WeakDictionaryWrapperTests.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 16.04.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

@testable import SwiftCollections
import XCTest

final class WeakDictionaryWrapperTests: XCTestCase {
    // MARK: - Subtypes
    final class SampleObject: Hashable {
        var hashValue: Int

        init(_ hashValue: Int) {
            self.hashValue = hashValue
        }

        static func == (lhs: SampleObject, rhs: SampleObject) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }

    // MARK: - Properties
    private let dictionarySize = 3
    private lazy var dictionary: [Int: SampleObject]? = {
        let tuples = (0..<dictionarySize).map { (key: $0, value: SampleObject($0)) }
        return Dictionary(tuples) { _, _ in fatalError() }
    }()

    // MARK: - Methods
    func testCount() {
        let weakDictionaryWrapper = WeakDictionaryWrapper(dictionary!)
        XCTAssertEqual(weakDictionaryWrapper.contents.count, dictionary!.count)
    }

    func testSubscript() {
        var weakDictionaryWrapper = WeakDictionaryWrapper(dictionary!)

        // Test subscript setter
        let sampleKey = dictionary!.count
        let sampleValue = dictionary!.first!.value
        weakDictionaryWrapper[sampleKey] = sampleValue
        XCTAssertEqual(weakDictionaryWrapper.contents.values.count, dictionary!.count + 1)

        // Test subscript getter
        XCTAssertEqual(weakDictionaryWrapper[sampleKey], sampleValue)

        // Test subscript setter when setting to nil
        weakDictionaryWrapper[sampleKey] = nil
        XCTAssertEqual(weakDictionaryWrapper[sampleKey], nil)
        XCTAssertEqual(weakDictionaryWrapper.contents.values.count, dictionary!.count)
    }

    func testCleaning() {
        let weakDictionaryWrapper = WeakDictionaryWrapper(dictionary!)
        dictionary = nil
        XCTAssertEqual(weakDictionaryWrapper.contents.isEmpty, true)
    }
}
