//
//  CreditCardFormatter.swift
//  CreditCardFormatter
//
//  Created by barbarity on 05/09/2019.
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

public enum CreditCardFormatters {
    public static let general: [CreditCardFormat] = [VISACreditCardFormat(),
                                                     MasterCardCreditCardFormat(),
                                                     AmericanExpressCreditCardFormat(),
                                                     DinersClubInternationalCreditCardFormat(),
                                                     DiscoverCreditCardFormat(),
                                                     JCBCreditCardFormat()]
    public static let all: [CreditCardFormat] = general + [ChinaUnionPayCreditCardFormat()]
}

/// A formatter that provides legible brand-specific representations of credit card numbers.
public final class CreditCardFormatter {
    public var delimiter: String
    public var repeatLastBlock: Bool
    public var formatters: [CreditCardFormat] = CreditCardFormatters.general
    private let unknownFormatter = UnknownCreditCardFormat()

    public init(delimiter: String = " ", repeatLastBlock: Bool = true) {
        self.delimiter = delimiter
        self.repeatLastBlock = repeatLastBlock
    }

    private func removeNonDecimalDigits(from string: String) -> String {
        let characterSet: CharacterSet = .decimalDigits
        return string.removingCharacters(in: characterSet.inverted)
    }

    private func selectFormatter(from string: String) -> CreditCardFormat {
        guard let formatter = formatters.first(where: { $0.shouldFormat(string) }) else { return unknownFormatter }
        return formatter
    }
    
    private func shouldRepeatLastBlock(for formatter: CreditCardFormat) -> Bool {
        return repeatLastBlock || formatter.brand == unknownFormatter.brand
    }

    public func formattedString(from string: String) -> String {
        let strippedString = removeNonDecimalDigits(from: string)
        let formatter = selectFormatter(from: strippedString)
        return formatter.formattedString(from: strippedString, delimiter: delimiter, repeatLastBlock: shouldRepeatLastBlock(for: formatter))
    }
    
    public func brand(from string: String) -> String {
        let strippedString = removeNonDecimalDigits(from: string)
        let formatter = selectFormatter(from: strippedString)
        return formatter.brand
    }

    public func isValid(_ string: String) -> Bool {
        let strippedString = removeNonDecimalDigits(from: string)
        let formatter = selectFormatter(from: strippedString)
        return formatter.isValid(strippedString)
    }
}

extension String {
    func removingCharacters(in set: CharacterSet) -> String {
        let filtered = unicodeScalars.lazy.filter { !set.contains($0) }
        return String(String.UnicodeScalarView(filtered))
    }
}
