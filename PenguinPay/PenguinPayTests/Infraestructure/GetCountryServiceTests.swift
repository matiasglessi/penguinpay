//
//  GetCountryServiceTests.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class GetCountryServiceTests: XCTestCase {
    
    func test_onServiceCall_returnsFourCaseCountries() {
        let getCountryService = DefaultGetCountryService()
        let countries = getCountryService.execute()
        XCTAssertEqual(countries.count, 4)
    }
}
