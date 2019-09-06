//
//  CreditCardFormatterTests.swift
//  CreditCardFormatterTests
//
//  Created by barbarity on 05/09/2019.
//
//  Copyright (c) 2019 Barbarity Apps
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
import CreditCardFormatter

final class CreditCardFormatterTests: XCTestCase {
    var sut: CreditCardFormatter!

    override func setUp() {
        super.setUp()
        sut = CreditCardFormatter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testEmptyStringReturnsEmptyFormattedString() {
        XCTAssert(sut.formattedString(from: "") == "")
    }

    func testWhitesSpacesAreDeleted() {
        XCTAssert(sut.formattedString(from: "    ") == "")
        XCTAssert(sut.formattedString(from: "   1") == "1")
        XCTAssert(sut.formattedString(from: "  12  ") == "12")
        XCTAssert(sut.formattedString(from: "  4  3") == "43")
    }

    func testWeirdCharactersAreFiltered() {
        XCTAssert(sut.formattedString(from: "#@@1#&$&#4") == "14")
    }

    func testDefaultConfiguration() {
        XCTAssert(sut.formattedString(from: "1289") == "1289")
        XCTAssert(sut.formattedString(from: "12891") == "1289 1")
        XCTAssert(sut.formattedString(from: "128911") == "1289 11")
        XCTAssert(sut.formattedString(from: "1289117") == "1289 117")
        XCTAssert(sut.formattedString(from: "12891173") == "1289 1173")
        XCTAssert(sut.formattedString(from: "128911738") == "1289 1173 8")
        XCTAssert(sut.formattedString(from: "1289117385") == "1289 1173 85")
        XCTAssert(sut.formattedString(from: "12891173853") == "1289 1173 853")
        XCTAssert(sut.formattedString(from: "128911738536") == "1289 1173 8536")
        XCTAssert(sut.formattedString(from: "1289117385361") == "1289 1173 8536 1")
        XCTAssert(sut.formattedString(from: "12891173853613") == "1289 1173 8536 13")
        XCTAssert(sut.formattedString(from: "12891173853613") == "1289 1173 8536 13")
        XCTAssert(sut.formattedString(from: "128911738536131") == "1289 1173 8536 131")
        XCTAssert(sut.formattedString(from: "1289117385361319") == "1289 1173 8536 1319")
    }

    func testStringsTooLongAreCut() {
        XCTAssert(sut.formattedString(from: "12891173853613195") == "1289 1173 8536 1319")
        XCTAssert(sut.formattedString(from: "12891173853613195123") == "1289 1173 8536 1319")
        XCTAssert(sut.formattedString(from: "1289117385361319512354") == "1289 1173 8536 1319")
    }

    func testWeirdCharactersDontAffectCount() {
        XCTAssert(sut.formattedString(from: "128911738@53613195") == "1289 1173 8536 1319")
        XCTAssert(sut.formattedString(from: "12dfgdf8911738@5361sdfds3195") == "1289 1173 8536 1319")
    }

    func testBlocksWithDifferentRange() {
        sut.blocks = [1, 2, 3, 4]

        XCTAssert(sut.formattedString(from: "1") == "1")
        XCTAssert(sut.formattedString(from: "11") == "1 1")
        XCTAssert(sut.formattedString(from: "112") == "1 12")
        XCTAssert(sut.formattedString(from: "1121") == "1 12 1")
        XCTAssert(sut.formattedString(from: "11212") == "1 12 12")
        XCTAssert(sut.formattedString(from: "112123") == "1 12 123")
        XCTAssert(sut.formattedString(from: "1121231") == "1 12 123 1")
        XCTAssert(sut.formattedString(from: "11212312") == "1 12 123 12")
        XCTAssert(sut.formattedString(from: "112123123") == "1 12 123 123")
        XCTAssert(sut.formattedString(from: "1121231234") == "1 12 123 1234")
    }

    func testDifferentDelimiter() {
        sut.delimiter = "-"
        XCTAssert(sut.formattedString(from: "1289") == "1289")
        XCTAssert(sut.formattedString(from: "12891") == "1289-1")
        XCTAssert(sut.formattedString(from: "128911") == "1289-11")
        XCTAssert(sut.formattedString(from: "1289117") == "1289-117")
        XCTAssert(sut.formattedString(from: "12891173") == "1289-1173")
        XCTAssert(sut.formattedString(from: "128911738") == "1289-1173-8")
        XCTAssert(sut.formattedString(from: "1289117385") == "1289-1173-85")
        XCTAssert(sut.formattedString(from: "12891173853") == "1289-1173-853")
        XCTAssert(sut.formattedString(from: "128911738536") == "1289-1173-8536")
        XCTAssert(sut.formattedString(from: "1289117385361") == "1289-1173-8536-1")
        XCTAssert(sut.formattedString(from: "12891173853613") == "1289-1173-8536-13")
        XCTAssert(sut.formattedString(from: "12891173853613") == "1289-1173-8536-13")
        XCTAssert(sut.formattedString(from: "128911738536131") == "1289-1173-8536-131")
        XCTAssert(sut.formattedString(from: "1289117385361319") == "1289-1173-8536-1319")
    }
}
