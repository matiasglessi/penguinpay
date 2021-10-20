//
//  GetCountryServiceMock.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class GetCountryServiceMock: GetCountryService {
    private var isServiceCalled = false

    func execute() -> [Country] {
        isServiceCalled = true
        return [Country(id: "KES", name: "Kenya", phonePrefix: "+254", numberOfDigitsAfterPrefix: 9)]
    }
    
    func isCalled() -> Bool {
        return isServiceCalled
    }

}
