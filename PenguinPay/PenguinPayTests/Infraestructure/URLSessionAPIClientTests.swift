//
//  URLSessionAPIClientTests.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class URLSessionAPIClientTests: XCTestCase {

    private var apiClient: URLSessionAPIClient!
    private let session = SessionMock()
  
    private let fakeURL = URL(string: "http://fake.url.com")
    private let missingDataError = APIClientError.missingData
    
    override func setUp() {
        apiClient = URLSessionAPIClient(session: session)
    }
    
    func test_whenSessionHasDataAndNoError_ThenTheJSONIsRetrieved() {
        let jsonData: [String : Any] = [ "rates" : [ "NGN" : 430.69 ] ]
        
        session.data = jsonToData(with: jsonData)
        
        apiClient.get(from: fakeURL) { (result) in

            switch result {
            case .success (let jsonDataFromAPI):
                
                if let ratesJSON = jsonData["rates"] as? [String : Any] {
                    XCTAssertEqual(ratesJSON["NGN"] as? ExchangeRate, jsonDataFromAPI["NGN"] as? ExchangeRate)
                }
                else {
                    XCTFail()
                }
            default:
                XCTFail()
            }
        }
    }
    
    
    func test_whenSessionHasErrorAndNoData_thenMissingDataErrorIsRetrieved() {
        apiClient.get(from: fakeURL, completion: { (result) in
            switch result {
            case .failure(let error):
                
                guard let error = error as? APIClientError else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(error, self.missingDataError)
            default:
                break
            }
        })
    }
    
    func jsonToData(with json: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return nil
        }
    }
}
