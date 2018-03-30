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
    // MARK: - Properties
    private lazy var baseBag: Bag<Int> = {
        // Assuming array init works properly
        // Testing it in-depth would require private member checking...
        let bag: Bag<Int> = [1, 2, 2]

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
        var uniqueElements = [Int]()
        for elem in baseBag { uniqueElements.append(elem.element) }
        XCTAssertEqual(baseBag.uniqueElements, uniqueElements)
    }

    func testTotalElements() {
        var totalElements = [Int]()
        for elem in baseBag {
            for _ in 0..<elem.count {
                totalElements.append(elem.element)
            }
        }

        XCTAssertEqual(baseBag.totalElements, totalElements)
    }

    func testDictionaryInit() {
        // Replicate base bag with dict init
        let compareBag: Bag<Int> = [
            1: 1,
            2: 2
        ]

        XCTAssertEqual(baseBag, compareBag)
    }

    func testEquatable() {
        var compareBag = baseBag
        XCTAssertEqual(baseBag, compareBag)
        compareBag.add(3)
        XCTAssertNotEqual(baseBag, compareBag)
    }

    func testAdd() {
        var bag: Bag<Int> = [1, 2]

        bag.add(1)
        XCTAssertEqual(bag[1], 2)

        bag.add(2, occurrences: 4)
        XCTAssertEqual(bag[2], 5)

        bag.add(3, occurrences: 3)
        XCTAssertEqual(bag[3], 3)
    }

    func testRemove() {
        var bag: Bag<Int> = [
            1,
            2, 2,
            3, 3, 3
        ]

        bag.remove(.any(0), of: 1)
        XCTAssertEqual(bag[1], 1)

        bag.remove(.any(1), of: 1)
        XCTAssertEqual(bag[1], 0)

        bag.remove(.all, of: 2)
        XCTAssertEqual(bag[2], 0)

        bag.remove(.any(2), of: 3)
        XCTAssertEqual(bag[3], 1)
    }
}
