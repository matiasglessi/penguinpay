//
//  BinaryConverterService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 20/10/2021.
//

import Foundation

protocol BinaryConverterService {
    func toBinary(decimal: Int) -> String
    func toDecimal(binary: String) -> Int
}


