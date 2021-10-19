//
//  GetCountryService.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

protocol GetCountryService {
    func execute() -> [Country]
}
