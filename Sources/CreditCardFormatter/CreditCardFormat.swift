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

public protocol CreditCardFormat {
    var blocks: [Int] { get }
    var brand: String { get }
    var repeatLastBlock: Bool { get }
    func shouldFormat(_ string: String) -> Bool
    func isValid(_ string: String) -> Bool
}

public extension CreditCardFormat {
    var repeatLastBlock: Bool {
        return false
    }

    func formattedString(from string: String, delimiter: String) -> String {
        var invertedBlocks = Array(blocks.reversed())
        var formattedString = ""
        var subIdx = 0
        guard var currentBlock = invertedBlocks.popLast() else { return formattedString }
        for character in string {
            if subIdx == currentBlock {
                if let nextBlock = invertedBlocks.popLast() {
                    formattedString.append(delimiter)
                    subIdx = 0
                    currentBlock = nextBlock
                } else {
                    if repeatLastBlock {
                        formattedString.append(delimiter)
                        subIdx = 0
                    } else {
                        return formattedString
                    }
                }
            }
            formattedString.append(character)
            subIdx += 1
        }

        return formattedString
    }

    func isValid(_ string: String) -> Bool {
        guard shouldFormat(string) else { return false }
        guard string.count == blocks.reduce(0, +) else { return false }
        return ValidationAlgorithms.luhnCheck(string)
    }
}
