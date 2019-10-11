//
//  VisaCreditCardFormatTests.swift
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

import CreditCardFormatter
import XCTest

class VisaCreditCardFormatTests: XCTestCase {
    private var sut: VISACreditCardFormat!

    private let nonVISACards: [String] = [
        "374614477865360",
        "354122905790162",
        "6011812610905673",
        "5365209594272267",
        "3529348020648944"
    ]

    private let invalidCheckDigitCards: [String] = [
        "4800703863248831",
        "4800703863248832",
        "4800703863248833",
        "4800703863248834",
        "4800703863248835",
        "4800703863248836",
        "4800703863248837",
        "4800703863248838",
        "4800703863248839",
    ]

    private let invalidCheckDigitCardsFormatted: [String] = [
        "4800 7038 6324 8831",
        "4800 7038 6324 8832",
        "4800 7038 6324 8833",
        "4800 7038 6324 8834",
        "4800 7038 6324 8835",
        "4800 7038 6324 8836",
        "4800 7038 6324 8837",
        "4800 7038 6324 8838",
        "4800 7038 6324 8839",
    ]

    private let validCreditCards = [
        "4800703863248830",
        "4085799482262802",
        "4205397653250196",
        "4101493548361101",
        "4186203413533892",
        "4244274573681698",
    ]

    private let validCreditCardsFormatted = [
        "4800 7038 6324 8830",
        "4085 7994 8226 2802",
        "4205 3976 5325 0196",
        "4101 4935 4836 1101",
        "4186 2034 1353 3892",
        "4244 2745 7368 1698",
    ]

    override func setUp() {
        super.setUp()
        sut = VISACreditCardFormat()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testVISABrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.visa)
    }

    func testRepeatBlockIsFalse() {
        XCTAssert(sut.repeatLastBlock == false)
    }

    func testNonVISACreditCardsAreInvalid() {
        nonVISACards.forEach { XCTAssert(!sut.isValid($0)) }
    }

    func testNonVISACardsShouldntBeFormatted() {
        nonVISACards.forEach { XCTAssert(!sut.shouldFormat($0)) }
    }

    func testVISACardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssert(!sut.isValid($0)) }
    }

    func testVISACardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }

    func testVISACardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }

    // MARK: Valid Credit Cards

    func testCorrectVISACardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }

    func testCorrectVISACardsAreValid() {
        validCreditCards.forEach { XCTAssert(sut.isValid($0)) }
    }    
}
