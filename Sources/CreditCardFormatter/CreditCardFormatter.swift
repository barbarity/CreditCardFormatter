//
//  CreditCardFormatter.swift
//  CreditCardFormatter
//
//  Created by barbarity on 05/09/2019.
//
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

public class CreditCardFormatter {
    public var delimiter: String = " "
    public var formatters: [CreditCardFormat] = [VISACreditCardFormat()]
    public var defaultBlocks: [Int] = [4, 4, 4, 4]

    public init() { }

    private func removeNonDecimalDigits(from string: String) -> String {
        let characterSet: CharacterSet = .decimalDigits
        return string.removingCharacters(in: characterSet.inverted)
    }

    public func formattedString(from string: String) -> String {
        let strippedString = removeNonDecimalDigits(from: string)

        let blocks = formatters.first(where: { $0.shouldFormat(strippedString) })?.blocks ?? defaultBlocks

        var invertedBlocks = Array(blocks.reversed())
        var formattedString = ""
        var subIdx = 0
        guard var currentBlock = invertedBlocks.popLast() else { return formattedString }
        for character in strippedString {
            if subIdx == currentBlock {
                guard let nextBlock = invertedBlocks.popLast() else { return formattedString }
                formattedString.append(delimiter)
                subIdx = 0
                currentBlock = nextBlock
            }
            formattedString.append(character)
            subIdx += 1
        }

        return formattedString
    }

    public func isValid(_ string: String) -> Bool {
        let strippedString = removeNonDecimalDigits(from: string)
        guard let formatter = formatters.first(where: { $0.shouldFormat(strippedString) }) else { return false }
        return formatter.isValid(strippedString)
    }
}

extension String {
    func removingCharacters(in set: CharacterSet) -> String {
        let filtered = unicodeScalars.lazy.filter { !set.contains($0) }
        return String(String.UnicodeScalarView(filtered))
    }
}
