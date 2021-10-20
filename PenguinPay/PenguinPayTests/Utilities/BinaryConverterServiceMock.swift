//
//  BinaryConverterServiceMock.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class BinaryConverterServiceMock: BinaryConverterService {
    func toBinary(decimal: Int) -> String {
        return "10100110"
    }
    
    func toDecimal(binary: String) -> Int {
        return 22
    }
}
