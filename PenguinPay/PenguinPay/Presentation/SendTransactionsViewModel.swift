//
//  SendTransactionsViewModel.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

class SendTransactionsViewModel {
    private let getCountryService: GetCountryService
    private let getExchangeRateService: GetExchangeRateService
    private let binaryConverterService: BinaryConverterService
    private var exchangeRate: ExchangeRate?

    init(getCountryService: GetCountryService, getExchangeRateService: GetExchangeRateService, binaryConverterService: BinaryConverterService) {
        self.getCountryService = getCountryService
        self.getExchangeRateService = getExchangeRateService
        self.binaryConverterService = binaryConverterService
    }
        
    func getExchangeRate(for countryId: String, completion: @escaping () -> Void) {
        getExchangeRateService.execute(countryID: countryId) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let exchangeRate):
                strongSelf.exchangeRate = exchangeRate
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
    
    func getCountryPrefix(for partialNumber: String) -> String {
        guard let country = getCountry(for: partialNumber) else {
            exchangeRate = nil
            return ""
        }
        return country.id
    }
    
    
    func getTransactionMessage(recipientName: String?, recipientCountry: String?, transactionValue: String?) -> String {

        guard let recipientName = recipientName, !recipientName.isEmpty else { return "" }
        guard let recipientCountry = recipientCountry, !recipientCountry.isEmpty else { return "" }
        guard let transactionValue = transactionValue, !transactionValue.isEmpty else { return "" }
        guard let exchangeRate = exchangeRate else { return "" }
        
        return recipientName + " will recieve " + "\n" + getTransactionInBinarian(exchangeRate, transactionValue) + "\n" + getConvertionExpression(exchangeRate, recipientCountry)
    }
    
    private func getConvertionExpression(_ exchangeRate: ExchangeRate, _ recipientCountry: String) -> String {
        return "(1 Binarian Dollar = " + String(exchangeRate) + " " +  String(recipientCountry) + ")"
    }
    
    private func getTransactionInBinarian(_ exchangeRate: ExchangeRate, _ transactionValue: String) -> String {
        let transactionValueInDecimal = binaryConverterService.toDecimal(binary: transactionValue)
        let finalTransactionValue = Double(transactionValueInDecimal) * exchangeRate
        
        return (isConvertionOutOfBounds(finalTransactionValue)) ?
        binaryConverterService.toBinary(decimal: Int.max) :
        binaryConverterService.toBinary(decimal: Int(finalTransactionValue))
    }
    
    private func isConvertionOutOfBounds(_ finalTransactionValue: Double) -> Bool {
        finalTransactionValue > Double(Int.max)
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
