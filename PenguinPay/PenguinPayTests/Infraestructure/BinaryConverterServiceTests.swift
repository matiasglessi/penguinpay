//
//  BinaryConverterServiceTests.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class BinaryConverterServiceTests: XCTestCase {

    func test_onServiceCallWithBinary10110_returnsDecimal22() {
        let binaryValue = "10110"
        let binaryService = DefaultBinaryConverterService()
        XCTAssertEqual(binaryService.toDecimal(binary: binaryValue), 22)
    }
    
    func test_onServiceCallWithDecimal22_returnsBinary10110() {
        let decimalValue = 22
        let binaryService = DefaultBinaryConverterService()
        XCTAssertEqual(binaryService.toBinary(decimal: decimalValue), "10110")
    }
    
}
