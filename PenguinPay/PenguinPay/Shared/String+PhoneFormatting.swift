//
//  String+PhoneFormatting.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

extension String {
    func apply(pattern: String, replacement: Character) -> String {
        var value = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < value.count else { return value }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacement else { continue }
            value.insert(patternCharacter, at: stringIndex)
        }
        return value
    }
}
