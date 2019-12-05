//
//  UnknownCreditCardFormatTests.swift
//  CreditCardFormatterTests
//
//  Created by barbarity on 06/10/2019.
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

@testable import CreditCardFormatter

final class UnknownCreditCardFormatTests: XCTestCase {
    private var sut: UnknownCreditCardFormat!

    override func setUp() {
        sut = UnknownCreditCardFormat()
    }

    override func tearDown() {
        sut = nil
    }

    func testUnknownBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.unknown)
    }

    func testShouldFormatAlwaysReturnsTrue() {
        XCTAssert(sut.shouldFormat(""))
        XCTAssert(sut.shouldFormat("4435345367"))
        XCTAssert(sut.shouldFormat("$"))
        XCTAssert(sut.shouldFormat("hoasdha3"))
        XCTAssert(sut.shouldFormat("ghskdgjsd"))
        XCTAssert(sut.shouldFormat("435345"))
        XCTAssert(sut.shouldFormat("<><,,."))
    }

    func testIsValidAlwaysReturnsFalse() {
        XCTAssertFalse(sut.isValid("45635737463949595"))
        XCTAssertFalse(sut.isValid("3475860048473949"))
        XCTAssertFalse(sut.isValid("13039687439676933"))
        XCTAssertFalse(sut.isValid("-"))
        XCTAssertFalse(sut.isValid("aklslksa"))
    }

}
