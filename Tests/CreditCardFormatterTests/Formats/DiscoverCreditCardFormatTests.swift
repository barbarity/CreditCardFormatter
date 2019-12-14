//
//  DiscoverCreditCardFormatTests.swift
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

final class DiscoverCreditCardFormatTests: XCTestCase {
    private var sut: DiscoverCreditCardFormat!
    
    private let nonDiscoverCards: [String] = [
        "4844454142127365",
        "3538684728624673",
        "5168441223630339",
        "5080741549588144561",
        "3529348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "6011790961194351",
        "6011790961194352",
        "6011790961194353",
        "6011790961194355",
        "6011790961194356",
        "6011790961194357",
        "6011790961194358",
        "6011790961194359"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "6011 7909 6119 4351",
        "6011 7909 6119 4352",
        "6011 7909 6119 4353",
        "6011 7909 6119 4355",
        "6011 7909 6119 4356",
        "6011 7909 6119 4357",
        "6011 7909 6119 4358",
        "6011 7909 6119 4359"
    ]
    
    private let validCreditCards = [
        "6011790961194354",
        "6011792456358809",
        "6011983134104166839",
        "6011989994603890",
        "6011635959685097",
        "6445678975565584"
    ]
    
    private let validCreditCardsFormatted = [
        "6011 7909 6119 4354",
        "6011 7924 5635 8809",
        "6011 9831 3410 4166 839",
        "6011 9899 9460 3890",
        "6011 6359 5968 5097",
        "6445 6789 7556 5584"
    ]
    
    private let shortCreditCards = [
        "60117909611943 ",
        "60117924563588",
        "601198313410",
        "60119899946",
        "601163595",
        "644567"
    ]
    
    override func setUp() {
        super.setUp()
        sut = DiscoverCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDiscoverBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.discover)
    }
    
    func testNonDiscoverCreditCardsAreInvalid() {
        nonDiscoverCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonDiscoverCardsShouldntBeFormatted() {
        nonDiscoverCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testDiscoverCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testDiscoverCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testDiscoverCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectDiscoverCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectDiscoverCardsAreValid() {
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
