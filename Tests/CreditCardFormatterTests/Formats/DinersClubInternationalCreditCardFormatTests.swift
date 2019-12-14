//
//  DinersClubInternationalCreditCardFormatTests.swift
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

final class DinersClubInternationalCreditCardFormatTests: XCTestCase {
    private var sut: DinersClubInternationalCreditCardFormat!
    
    private let nonDinersClubInternationalCards: [String] = [
        "4844454142127365",
        "3538684728624673",
        "5168441223630339",
        "5080741549588144561",
        "3529348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "30043277253241",
        "30043277253242",
        "30043277253243",
        "30043277253244",
        "30043277253246",
        "30043277253247",
        "30043277253248",
        "30043277253249"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "3004 327725 3241",
        "3004 327725 3242",
        "3004 327725 3243",
        "3004 327725 3244",
        "3004 327725 3246",
        "3004 327725 3247",
        "3004 327725 3248",
        "3004 327725 3249"
    ]
    
    private let validCreditCards = [
        "36507432190579",
        "36269184308632",
        "36040843639646",
        "30420694409206",
        "30440083359978",
        "30322945982116"
    ]
    
    private let validCreditCardsFormatted = [
        "3650 743219 0579",
        "3626 918430 8632",
        "3604 084363 9646",
        "3042 069440 9206",
        "3044 008335 9978",
        "3032 294598 2116"
    ]
    
    private let shortCreditCards = [
        "365074321905",
        "36269184308",
        "3604084363",
        "30420694",
        "30440083",
        "30322"
    ]
    
    override func setUp() {
        super.setUp()
        sut = DinersClubInternationalCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDinersClubInternationalBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.dinersClubInternational)
    }
    
    func testNonDinersClubInternationalCreditCardsAreInvalid() {
        nonDinersClubInternationalCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonDinersClubInternationalCardsShouldntBeFormatted() {
        nonDinersClubInternationalCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testDinersClubInternationalCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testDinersClubInternationalCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testDinersClubInternationalCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectDinersClubInternationalCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectDinersClubInternationalCardsAreValid() {
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
