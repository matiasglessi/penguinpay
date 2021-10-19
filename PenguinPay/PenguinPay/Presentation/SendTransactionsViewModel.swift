//
//  SendTransactionsViewModel.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

class SendTransactionsViewModel {
    private let getCountryService: GetCountryService

    init(getCountryService: GetCountryService) {
        self.getCountryService = getCountryService
    }
    
    func getCountryPrefix(for partialNumber: String) -> String {
        guard let country = getCountry(for: partialNumber) else { return "" }
        return country.id
    }
    
    private func getCountry(for partialNumber: String) -> Country? {
        let countries = getCountryService.execute()
        for country in countries {
            if isValidPhoneNumber(for: country, and: partialNumber) {
                return country
            }
        }
        return nil
    }
    
    private func isValidPhoneNumber(for country: Country, and partialNumber: String) -> Bool {
        partialNumber.starts(with: country.phonePrefix) && (partialNumber.count - 4) == country.numberOfDigitsAfterPrefix
    }
}
