//
//  MasterCardCreditCardFormat.swift
//  CreditCardFormatter
//
//  Created by Ivan Sapozhnik on 05.12.19.
//  Copyright © 2019 Barbarity Apps. All rights reserved.
//

import Foundation

public extension CreditCardBrands {
    static let masterCard = "MasterCard"
}

public struct MasterCardCreditCardFormat: CreditCardFormat {
    public let blocks: [Int] = [4, 4, 4, 4]
    public let brand: String = CreditCardBrands.masterCard

    public init() {}

    public func shouldFormat(_ string: String) -> Bool {
        return (50...55).map { String($0) }.contains(String(string.prefix(2)))
    }
}
