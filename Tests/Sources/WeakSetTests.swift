//
//  WeakSetTests.swift
//  SwiftCollectionsTests
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Released as a part of SwiftCollections. https://www.github.com/fredpi/SwiftCollections
//

@testable import SwiftCollections
import XCTest

class WeakSetTests: XCTestCase {
    // MARK: - Subtypes
    class SampleObject: Hashable {
        var hashValue: Int

        init(hashValue: Int) {
            self.hashValue = hashValue
        }

        static func == (lhs: WeakSetTests.SampleObject, rhs: WeakSetTests.SampleObject) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }

    // MARK: - Properties
    private let setSize = 3
    private lazy var set: Set<SampleObject>? = {
        Set((0..<setSize).map { index in SampleObject(hashValue: index) })
    }()

    // MARK: - Methods
    func testCount() {
        let weakSet = WeakSet(set!)
        XCTAssertEqual(weakSet.contents.count, set!.count)
    }

    func testIsEmpty() {
        let weakSet = WeakSet(set!)
        XCTAssertEqual(weakSet.isEmpty, set!.isEmpty)
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
        XCTAssertEqual(weakSet.contents.count, 0)
        XCTAssertEqual(weakSet.isEmpty, true)
    }
}
