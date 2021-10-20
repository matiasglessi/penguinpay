//
//  DefaultBinaryConverterService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 20/10/2021.
//

import Foundation

class DefaultBinaryConverterService: BinaryConverterService {
    func toBinary(decimal: Int) -> String {
        String(decimal, radix: 2)
    }
    
    func toDecimal(binary: String) -> Int {
        guard let number = Int(binary, radix: 2) else {
            return 0
        }
        return number
    }
}
