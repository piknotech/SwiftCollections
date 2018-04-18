//
//  WeakDictionaryTests.swift
//  SwiftCollections
//
//  Created by Frederick Pietschmann on 16.04.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import Foundation

@testable import SwiftCollections
import XCTest

class WeakDictionaryTests: XCTestCase {
    // MARK: - Subtypes
    class SampleObject: Hashable {
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
        let weakDictionary = WeakDictionary(dictionary!)
        XCTAssertEqual(weakDictionary.contents.count, dictionary!.count)
    }

    func testSubscript() {
        var weakDictionary = WeakDictionary(dictionary!)

        // Test subscript setter
        let sampleKey = dictionary!.count
        let sampleValue = dictionary!.first!.value
        weakDictionary[sampleKey] = sampleValue
        XCTAssertEqual(weakDictionary.contents.values.count, dictionary!.count + 1)

        // Test subscript getter
        XCTAssertEqual(weakDictionary[sampleKey], sampleValue)

        // Test subscript setter when setting to nil
        weakDictionary[sampleKey] = nil
        XCTAssertEqual(weakDictionary[sampleKey], nil)
        XCTAssertEqual(weakDictionary.contents.values.count, dictionary!.count)
    }

    func testCleaning() {
        let weakDictionary = WeakDictionary(dictionary!)
        dictionary = nil
        XCTAssertEqual(weakDictionary.contents.isEmpty, true)
    }
}
