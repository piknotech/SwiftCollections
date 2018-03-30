//
//  BagTests.swift
//  SwiftCollectionsTests
//
//  Created by Frederick Pietschmann on 12.03.18.
//  Released as a part of SwiftCollections. https://www.github.com/fredpi/SwiftCollections
//

@testable import SwiftCollections
import XCTest

class BagTests: XCTestCase {
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
    private let object1 = SampleObject(1)
    private let object2 = SampleObject(2)
    private let object3 = SampleObject(3)
    private lazy var baseBag: Bag<SampleObject> = {
        // Assuming array init works properly
        // Testing it in-depth would require private member checking...
        let bag: Bag<SampleObject> = [object1, object2, object2]

        return bag
    }()

    // MARK: - Methods
    func testUniqueCount() {
        XCTAssertEqual(baseBag.count, baseBag.uniqueCount)
    }

    func testTotalCount() {
        var totalCount = 0
        for elem in baseBag { totalCount += elem.count }
        XCTAssertEqual(baseBag.totalCount, totalCount)
    }

    func testUniqueElements() {
        var uniqueElements = [SampleObject]()
        for elem in baseBag { uniqueElements.append(elem.element) }
        XCTAssertEqual(baseBag.uniqueElements, uniqueElements)
    }

    func testTotalElements() {
        var totalElements = [SampleObject]()
        for elem in baseBag {
            for _ in 0..<elem.count {
                totalElements.append(elem.element)
            }
        }

        XCTAssertEqual(baseBag.totalElements, totalElements)
    }

    func testDictionaryInit() {
        // Replicate base bag with dict init
        let compareBag: Bag<SampleObject> = [
            object1: 1,
            object2: 2
        ]

        XCTAssertEqual(baseBag, compareBag)
    }

    func testAdd() {
        var bag: Bag<SampleObject> = [object1, object2]

        bag.add(object1)
        XCTAssertEqual(bag[object1], 2)

        bag.add(object2, occurrences: 4)
        XCTAssertEqual(bag[object2], 5)

        bag.add(object3, occurrences: 3)
        XCTAssertEqual(bag[object3], 3)
    }

    func testRemove() {
        var bag: Bag<SampleObject> = [
            object1,
            object2, object2,
            object3, object3, object3
        ]

        bag.remove(.any(0), of: object1)
        XCTAssertEqual(bag[object1], 1)

        bag.remove(.any(1), of: object1)
        XCTAssertEqual(bag[object1], 0)

        bag.remove(.all, of: object2)
        XCTAssertEqual(bag[object2], 0)

        bag.remove(.any(2), of: object3)
        XCTAssertEqual(bag[object3], 1)
    }
}
