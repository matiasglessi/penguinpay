//
//  GetExchangeRateService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

protocol GetExchangeRateService {
    func execute(countryID: String, completion: @escaping (Result<ExchangeRate>) -> Void)
}
