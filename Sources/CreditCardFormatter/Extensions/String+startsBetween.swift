//
//  String+startsBetween.swift
//  CreditCardFormatter
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

import Foundation

extension String {
    func starts(between initial: String, and final: String) -> Bool {
        let maxCount = max(initial.count, final.count)
        guard
            let initialNumber = Int(initial),
            let finalNumber = Int(final),
            let prefix = Int(self.prefix(maxCount))
            else { return false }
        
        let initialNormalized = initialNumber * (maxCount - initial.count + 1)
        let finalNormalized = finalNumber  * (maxCount - final.count + 1)
        
        return prefix >= initialNormalized && prefix <= finalNormalized
    }
}
