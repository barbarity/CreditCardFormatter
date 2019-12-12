//
//  ChinaUnionPayCreditCardFormatTests.swift
//  CreditCardFormatterTests
//
//  Created by barbarity on 12/12/2019.
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

final class ChinaUnionPayCreditCardFormatTests: XCTestCase {
    private var sut: ChinaUnionPayCreditCardFormat!
    
    private let nonChinaUnionPayCards: [String] = [
        "4844454142127365",
        "3538684728624673",
        "5168441223630339",
        "5080741549588144561",
        "3529348020648944"
    ]
    
    private let invalidCheckDigitCards: [String] = [
        "62600094752489240",
        "62600094752489241",
        "62600094752489243",
        "62600094752489244",
        "62600094752489245",
        "62600094752489246",
        "62600094752489247",
        "62600094752489248",
        "62600094752489249"
    ]
    
    private let invalidCheckDigitCardsFormatted: [String] = [
        "6260 0094 7524 8924 0",
        "6260 0094 7524 8924 1",
        "6260 0094 7524 8924 3",
        "6260 0094 7524 8924 4",
        "6260 0094 7524 8924 5",
        "6260 0094 7524 8924 6",
        "6260 0094 7524 8924 7",
        "6260 0094 7524 8924 8",
        "6260 0094 7524 8924 9"
    ]
    
    private let validCreditCards = [
        "62600094752489242",
        "6267873799876060",
        "6284238414361469",
        "6220330087141035762",
        "62890395646719994",
        "8107894562345456548"
    ]
    
    private let validCreditCardsFormatted = [
        "6260 0094 7524 8924 2",
        "6267 8737 9987 6060",
        "6284 2384 1436 1469",
        "6220 3300 8714 1035 762",
        "6289 0395 6467 1999 4",
        "8107 8945 6234 5456 548"
    ]
    
    private let shortCreditCards = [
        "62600094",
        "6267873",
        "6284238414361",
        "6220330087",
        "628903956467",
        "8107"
    ]
    
    override func setUp() {
        super.setUp()
        sut = ChinaUnionPayCreditCardFormat()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testChinaUnionPayBrandIsCorrect() {
        XCTAssert(sut.brand == CreditCardBrands.chinaUnionPay)
    }
    
    func testNonChinaUnionPayCreditCardsAreInvalid() {
        nonChinaUnionPayCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testNonChinaUnionPayCardsShouldntBeFormatted() {
        nonChinaUnionPayCards.forEach { XCTAssertFalse(sut.shouldFormat($0)) }
    }
    
    func testChinaUnionPayCardsWithWrongCheckDigitAreInvalid() {
        invalidCheckDigitCards.forEach { XCTAssertFalse(sut.isValid($0)) }
    }
    
    func testChinaUnionPayCardsWithWrongCheckDigitShouldFormat() {
        invalidCheckDigitCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testChinaUnionPayCardsWithWrongCheckDigitFormat() {
        for (formattedCard, card) in zip(invalidCheckDigitCardsFormatted, invalidCheckDigitCards) {
            XCTAssert(formattedCard == sut.formattedString(from: card, delimiter: " "))
        }
    }
    
    // MARK: Valid Credit Cards
    
    func testCorrectChinaUnionPayCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }
    
    func testCorrectChinaUnionPayCardsAreValid() {
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
