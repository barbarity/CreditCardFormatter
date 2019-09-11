//
//  CreditCardFormat.swift
//  CreditCardFormatter
//
//  Created by barbarity on 10/09/2019.
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

import Foundation

public enum CreditCardBrands {
    static let unknown = "UNKNOWN"
}

public protocol CreditCardFormat {
    var blocks: [Int] { get }
    var brand: String { get }
    func shouldFormat(_ string: String) -> Bool
    func isValid(_ string: String) -> Bool
}

public extension CreditCardFormat {
    private func luhnCheck(_ string: String) -> Bool {
        var sum = 0
        for (idx, character) in string.reversed().enumerated() {
            guard let digit = character.wholeNumberValue else { return false }
            let isOdd = idx % 2 == 1
            if isOdd {
                if digit == 9 {
                    sum += 9
                } else {
                    sum += (digit * 2) % 9
                }
            } else {
                sum += digit
            }
        }
        return sum % 10 == 0
    }

    func isValid(_ string: String) -> Bool {
        guard string.count == blocks.reduce(0, +) else { return false }
        return luhnCheck(string)
    }
}
