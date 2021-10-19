//
//  DefaultGetExchangeRateService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

class DefaultGetExchangeRateService: GetExchangeRateService {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute(countryID: String, completion: @escaping (Result<ExchangeRate>) -> Void) {
        apiClient.get(from: URL(string: "https://openexchangerates.org/api/latest.json?app_id=0579c709c4aa411b99d80e302280f1b2&symbols=" + countryID)) { result in
            
            switch result {
            case .success(let jsonData):
                if let rate = jsonData[countryID] as? ExchangeRate {
                     completion(.success(rate))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
