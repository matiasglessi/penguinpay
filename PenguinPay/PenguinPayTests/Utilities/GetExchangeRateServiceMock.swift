//
//  GetExchangeRateServiceMock.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class GetExchangeRateServiceMock: GetExchangeRateService {
    
    private var isServiceCalled = false

    func execute(countryID: String, completion: @escaping (Result<ExchangeRate>) -> Void) {
        isServiceCalled = true
        completion(.success(480.0))
    }
    
    func isCalled() -> Bool {
        return isServiceCalled
    }
}
