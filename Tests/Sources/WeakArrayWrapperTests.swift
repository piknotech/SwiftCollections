//
//  WeakArrayWrapperTests.swift
//  SwiftCollectionsTests
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

@testable import SwiftCollections
import XCTest

final class WeakArrayWrapperTests: XCTestCase {
    // MARK: - Subtypes
    final class SampleObject { }

    // MARK: - Properties
    private let arraySize = 3
    private lazy var array: [SampleObject]? = {
        (0..<arraySize).map { _ in SampleObject() }
    }()

    // MARK: - Methods
    func testCount() {
        let weakArrayWrapper = WeakArrayWrapper(array!)
        XCTAssertEqual(weakArrayWrapper.contents.count, array!.count)
    }

    func testAddingAndRemoving() {
        var weakArrayWrapper = WeakArrayWrapper(array!)

        // Test adding
        let sample = array!.first!
        let sampleCount = 3
        for _ in 0..<sampleCount { weakArrayWrapper.add(sample) }
        XCTAssertEqual(weakArrayWrapper.contents.filter { $0 === sample }.count, sampleCount + 1)

        // Test removing
        weakArrayWrapper.removeIdentical(to: sample)
        XCTAssertEqual(weakArrayWrapper.contents.count, arraySize - 1)
    }

    func testCleaning() {
        let weakArrayWrapper = WeakArrayWrapper(array!)
        array = nil
        XCTAssertEqual(weakArrayWrapper.contents.isEmpty, true)
    }
}
