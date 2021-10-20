//
//  SendTransactionsViewModelTests.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import XCTest
@testable import PenguinPay

class SendTransactionsViewModelTests: XCTestCase {
    
    private let getExchangeService = GetExchangeRateServiceMock()
    private let getCountryService = GetCountryServiceMock()

    func test_onGetExchangeRate_callsGetExchangeRateService() {
        let sendTransactionsViewModel = makeViewModelSUT()
        
        sendTransactionsViewModel.getExchangeRate(for: "") { [weak self] in
            guard let strongSelf = self else { return }

            XCTAssert(strongSelf.getExchangeService.isCalled())
        }
    }
    
    func test_onGetCountryPrefix_callsGetCountryService() {
        let sendTransactionsViewModel = makeViewModelSUT()
        let _ = sendTransactionsViewModel.getCountryPrefix(for: "")
        XCTAssert(getCountryService.isCalled())
    }
    
    func test_onGetTransactionMessageWithNoRecipientName_shouldReturnEmptyMessage() {
        let sendTransactionsViewModel = makeViewModelSUT()
        let message = sendTransactionsViewModel.getTransactionMessage(recipientName: "", recipientCountry: "ARG", transactionValue: "100101")
        XCTAssert(message.isEmpty)
    }
    
    func test_onGetTransactionMessageWithNoRecipientCountry_shouldReturnEmptyMessage() {
        let sendTransactionsViewModel = makeViewModelSUT()
        let message = sendTransactionsViewModel.getTransactionMessage(recipientName: "Matias", recipientCountry: "", transactionValue: "100101")
        XCTAssert(message.isEmpty)
    }
    
    func test_onGetTransactionMessageWithNoTransactionValue_shouldReturnEmptyMessage() {
        let sendTransactionsViewModel = makeViewModelSUT()
        let message = sendTransactionsViewModel.getTransactionMessage(recipientName: "Matias", recipientCountry: "ARG", transactionValue: "")
        XCTAssert(message.isEmpty)
    }
    
    
    func test_onGetTransactionMessageWithDownloadedExchange_shouldReturnMessage() {
        let sendTransactionsViewModel = makeViewModelSUT()
        sendTransactionsViewModel.getExchangeRate(for: "") {
            let message = sendTransactionsViewModel.getTransactionMessage(recipientName: "Matias", recipientCountry: "ARG", transactionValue: "100101")
            XCTAssertFalse(message.isEmpty)
        }
    }
    
    func test_onGetTransactionMessageWithNoExchange_shouldReturnEmptyMessage() {
        let sendTransactionsViewModel = makeViewModelSUT()
        let message = sendTransactionsViewModel.getTransactionMessage(recipientName: "Matias", recipientCountry: "ARG", transactionValue: "100101")
        XCTAssert(message.isEmpty)
    }
    
    private func makeViewModelSUT() -> SendTransactionsViewModel {
        SendTransactionsViewModel(
            getCountryService: getCountryService,
            getExchangeRateService: getExchangeService,
            binaryConverterService: BinaryConverterServiceMock())
    }
}
