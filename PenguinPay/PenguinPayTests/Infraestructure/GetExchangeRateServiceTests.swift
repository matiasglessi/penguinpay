//
//  GetExchangeRateServiceTests.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class GetExchangeRateServiceTests: XCTestCase {
    
    func test_onServiceExecutionWithCountryID_serviceReturnsSuccessResultOfExchangeRate() {
        let apiClient = APIClientMock()
        let countryCode = "NGN"
        apiClient.result = .success([countryCode: 430.6])
        let getExchangeService = DefaultGetExchangeRateService(apiClient: apiClient)
        getExchangeService.execute(countryID: countryCode) { result in
            switch result {
            case .success(let rate):
                XCTAssertEqual(rate, 430.6)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_onServiceExecutionWithRandomFailure_serviceReturnsFailurefulResult() {
        let apiClient = APIClientMock()
        let countryCode = "NGN"
        apiClient.result = .failure(getRandomFailure())
        let getExchangeService = DefaultGetExchangeRateService(apiClient: apiClient)
        getExchangeService.execute(countryID: countryCode) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    private func getRandomFailure() -> APIClientError {
        guard let error = APIClientError.allCases.randomElement() else {
            return APIClientError.invalidURL
        }
        return error
    }
}
