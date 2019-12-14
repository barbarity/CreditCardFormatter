//
//  AmericanExpressCreditCardFormatTests.swift
//  CreditCardFormatterTests
//
//  Created by barbarity on 06/12/2019.
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

final class AmericanExpressCreditCardFormatTests: XCTestCase {
    private var sut: AmericanExpressCreditCardFormat!
    
    private let nonAmericanExpressCards: [String] = [
        "4844454142127365",
        "3538684728624673",
        "5168441223630339",
        "5080741549588144561",
        "3529348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "371642190784802",
        "371642190784803",
        "371642190784804",
        "371642190784805",
        "371642190784806",
        "371642190784807",
        "371642190784808",
        "371642190784809"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "3716 421907 84802",
        "3716 421907 84803",
        "3716 421907 84804",
        "3716 421907 84805",
        "3716 421907 84806",
        "3716 421907 84807",
        "3716 421907 84808",
        "3716 421907 84809"
    ]
    
    private let validCreditCards = [
        "372460271317501",
        "376548709104271",
        "374332781797126",
        "341671055800086",
        "378862664418057",
        "340072752075281"
    ]
    
    private let validCreditCardsFormatted = [
        "3724 602713 17501",
        "3765 487091 04271",
        "3743 327817 97126",
        "3416 710558 00086",
        "3788 626644 18057",
        "3400 727520 75281"
    ]
    
    private let shortCreditCards = [
        "3724602",
        "376548",
        "37433",
        "3416710558",
        "3788626644180",
        "3400727520"
    ]
    
    override func setUp() {
        super.setUp()
        sut = AmericanExpressCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAmericanExpressBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.americanExpress)
    }
    
    func testNonAmericanExpressCreditCardsAreInvalid() {
        nonAmericanExpressCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonAmericanExpressCardsShouldntBeFormatted() {
        nonAmericanExpressCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testAmericanExpressCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testAmericanExpressCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testAmericanExpressCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectAmericanExpressCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectAmericanExpressCardsAreValid() {
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
