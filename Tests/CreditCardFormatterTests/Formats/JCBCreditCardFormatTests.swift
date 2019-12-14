//
//  JCBCreditCardFormatTests.swift
//  CreditCardFormatterTests
//
//  Created by barbarity on 14/12/2019.
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

import CreditCardFormatter
import XCTest

final class JCBCreditCardFormatTests: XCTestCase {
    private var sut: JCBCreditCardFormat!
    
    private let nonJCBCards: [String] = [
        "4844454142127365",
        "8538684728624673",
        "5168441223630339",
        "5080741549588144561",
        "3527348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "3536628874133611",
        "3536628874133612",
        "3536628874133613",
        "3536628874133614",
        "3536628874133615",
        "3536628874133616",
        "3536628874133617",
        "3536628874133618"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "3536 6288 7413 3611",
        "3536 6288 7413 3612",
        "3536 6288 7413 3613",
        "3536 6288 7413 3614",
        "3536 6288 7413 3615",
        "3536 6288 7413 3616",
        "3536 6288 7413 3617",
        "3536 6288 7413 3618"
    ]
    
    private let validCreditCards = [
        "3536628874133619",
        "3533521742335958",
        "3530705851397693380",
        "3539748162980013",
        "3531301377125897",
        "3545979743084770711"
    ]
    
    private let validCreditCardsFormatted = [
        "3536 6288 7413 3619",
        "3533 5217 4233 5958",
        "3530 7058 5139 7693 380",
        "3539 7481 6298 0013",
        "3531 3013 7712 5897",
        "3545 9797 4308 4770 711"
    ]
    
    private let shortCreditCards = [
        "3536628874",
        "353352174",
        "35307058",
        "353974",
        "353130",
        "35459797"
    ]
    
    override func setUp() {
        super.setUp()
        sut = JCBCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testJCBBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.jcb)
    }
    
    func testNonJCBCreditCardsAreInvalid() {
        nonJCBCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonJCBCardsShouldntBeFormatted() {
        nonJCBCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testJCBCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testJCBCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testJCBCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectJCBCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectJCBCardsAreValid() {
        validCreditCards.forEach { XCTAssert(sut.isValid($0)) }
    }
    
    // MARK: Short Credit Cards
    
    func testShortCreditCardsShouldFormat() {
        shortCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testShortCreditCardsAreInvalid() {
        shortCreditCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
}
