//
//  MasterCardCreditCardFormatTests.swift
//  CreditCardFormatterTests
//
//  Created by Ivan Sapozhnik on 05.12.19.
//  Copyright © 2019 Barbarity Apps. All rights reserved.
//

import CreditCardFormatter
import XCTest

class MasterCardCreditCardFormatTests: XCTestCase {
    private var sut: MasterCardCreditCardFormat!

    private let validCreditCards = [
        "5194400636767029",
        "5507625514874263",
        "5338096947937009",
        "5493528122424453",
        "5547666126016796",
        "5132331455922657"
    ]

    private let invalidCreditCards = [
        "519440063676702912"
    ]

    private let validCreditCardsFormatted = [
        "5194 4006 3676 7029",
        "5507 6255 1487 4263",
        "5338 0969 4793 7009",
        "5493 5281 2242 4453",
        "5547 6661 2601 6796",
        "5132 3314 5592 2657"
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

    func testRepeatBlockIsFalse() {
        XCTAssert(sut.repeatLastBlock == false)
    }

    // MARK: Valid Credit Cards

    func testCorrectMasterCardCardsShouldFormat() {
        validCreditCards.forEach { XCTAssert(sut.shouldFormat($0)) }
    }

    func testCorrectMasterCardCardsAreValid() {
        validCreditCards.forEach { XCTAssert(sut.isValid($0), "\($0) is invalid") }
    }

    func testInCcorrectMasterCardCardsAreInvalid() {
        invalidCreditCards.forEach { XCTAssert(!sut.isValid($0)) }
    }

    func testValidMasterCardCardsAreFormattedCorrectly() {
        for (index, card) in validCreditCards.enumerated() {
            XCTAssert(validCreditCardsFormatted[index] == sut.formattedString(from: card, delimiter: " "), "format for \(card) is wrong")
        }
    }
}
