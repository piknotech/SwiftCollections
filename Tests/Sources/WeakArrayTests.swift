//
//  WeakArrayTests.swift
//  SwiftCollectionsTests
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

@testable import SwiftCollections
import XCTest

class WeakArrayTests: XCTestCase {
    // MARK: - Subtypes
    class SampleObject { }

    // MARK: - Properties
    private let arraySize = 3
    private lazy var array: [SampleObject]? = {
        (0..<arraySize).map { _ in SampleObject() }
    }()

    // MARK: - Methods
    func testCount() {
        let weakArray = WeakArray(array!)
        XCTAssertEqual(weakArray.contents.count, array!.count)
    }

    func testAddingAndRemoving() {
        var weakArray = WeakArray(array!)

        // Test adding
        let sample = array!.first!
        let sampleCount = 3
        for _ in 0..<sampleCount { weakArray.add(sample) }
        XCTAssertEqual(weakArray.contents.filter { $0 === sample }.count, sampleCount + 1)

        // Test removing
        weakArray.removeIdentical(to: sample)
        XCTAssertEqual(weakArray.contents.count, arraySize - 1)
    }

    func testCleaning() {
        let weakArray = WeakArray(array!)
        array = nil
        XCTAssertEqual(weakArray.contents.isEmpty, true)
    }
}
