//
//  WeakSetTests.swift
//  SwiftCollectionsTests
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

@testable import SwiftCollections
import XCTest

final class WeakSetTests: XCTestCase {
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
    private let setSize = 3
    private lazy var set: Set<SampleObject>? = {
        Set((0..<setSize).map { SampleObject($0) })
    }()

    // MARK: - Methods
    func testCount() {
        let weakSet = WeakSet(set!)
        XCTAssertEqual(weakSet.contents.count, set!.count)
    }

    func testInsertingAndRemoving() {
        var weakSet = WeakSet(set!)

        // Test inserting
        let sample = set!.first!
        let sampleCount = 3
        for _ in 0..<sampleCount { weakSet.insert(sample) }
        XCTAssertEqual(weakSet.contents.filter { $0 === sample }.count, 1)

        // Test removing
        weakSet.remove(sample)
        XCTAssertEqual(weakSet.contents.count, setSize - 1)
    }

    func testCleaning() {
        let weakSet = WeakSet(set!)
        set = nil
        XCTAssertEqual(weakSet.contents.isEmpty, true)
    }
}
