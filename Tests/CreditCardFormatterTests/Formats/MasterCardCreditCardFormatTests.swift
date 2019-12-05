//
//  MasterCardCreditCardFormatTests.swift
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

final class MasterCardCreditCardFormatTests: XCTestCase {
    private var sut: MasterCardCreditCardFormat!
    
    private let nonMasterCardCards: [String] = [
        "374614477865360",
        "354122905790162",
        "6011812610905673",
        "4365209594272267",
        "3529348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "5168441223630331",
        "5168441223630332",
        "5168441223630333",
        "5168441223630334",
        "5168441223630335",
        "5168441223630336",
        "5168441223630337",
        "5168441223630338"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "5168 4412 2363 0331",
        "5168 4412 2363 0332",
        "5168 4412 2363 0333",
        "5168 4412 2363 0334",
        "5168 4412 2363 0335",
        "5168 4412 2363 0336",
        "5168 4412 2363 0337",
        "5168 4412 2363 0338"
    ]
    
    private let validCreditCards = [
        "5168441223630339",
        "5401917703173202",
        "5494867880877281",
        "5308407102097388",
        "5168441223630339",
        "2710132113458788"
    ]
    
    private let validCreditCardsFormatted = [
        "5168 4412 2363 0339",
        "5401 9177 0317 3202",
        "5494 8678 8087 7281",
        "5308 4071 0209 7388",
        "5168 4412 2363 0339",
        "2710 1321 1345 8788"
    ]
    
    private let shortCreditCards = [
        "516844122363",
        "54019177",
        "549486",
        "5308407",
        "51684",
        "27101321"
    ]
    
    override func setUp() {
        super.setUp()
        sut = MasterCardCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMasterCardBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.masterCard)
    }
    
    func testNonMasterCardCreditCardsAreInvalid() {
        nonMasterCardCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonMasterCardCardsShouldntBeFormatted() {
        nonMasterCardCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testMasterCardCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testMasterCardCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testMasterCardCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectMasterCardCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectMasterCardCardsAreValid() {
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
