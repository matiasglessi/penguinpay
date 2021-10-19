//
//  DefaultGetCountryService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

class DefaultGetCountryService: GetCountryService {
    private let countries = [
        Country(id: "KES", name: "Kenya", phonePrefix: "+254", numberOfDigitsAfterPrefix: 9),
        Country(id: "NGN", name: "Nigeria", phonePrefix: "+234", numberOfDigitsAfterPrefix: 7),
        Country(id: "TZS", name: "Tanzania", phonePrefix: "+255", numberOfDigitsAfterPrefix: 9),
        Country(id: "UGX", name: "Uganda", phonePrefix: "+256", numberOfDigitsAfterPrefix: 7)
    ]
    
    func execute() -> [Country] {
        return countries
    }
}
