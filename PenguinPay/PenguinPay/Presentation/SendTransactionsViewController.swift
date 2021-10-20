//
//  ViewController.swift
//  PenguinPay
//
//  Created by Matias Glessi on 18/10/2021.
//

import UIKit

class SendTransactionsViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var transactionValueTextField: UITextField!
    
    @IBOutlet weak var transactionPreviewMessageLabel: UILabel!

    @IBOutlet weak var sendTransactionButton: UIButton!
    
    private var viewModel: SendTransactionsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SendTransactionsViewModel(
            getCountryService: DefaultGetCountryService(),
            getExchangeRateService: DefaultGetExchangeRateService(apiClient: URLSessionAPIClient()),
            binaryConverterService: DefaultBinaryConverterService())
        
        phoneNumberTextField.delegate = self
        transactionValueTextField.delegate = self
        fullNameTextField.delegate = self
        sendTransactionButton.disable()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenTapped(_:))))
    }
    
    @objc func screenTapped(_ sender: UITapGestureRecognizer? = nil) {
        fullNameTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        transactionValueTextField.resignFirstResponder()
    }
    
    @IBAction func sendTransactionTapped(_ sender: Any) {
        
        let message = viewModel.getTransactionMessage(
            recipientName: fullNameTextField.text,
            recipientCountry: countryTextField.text,
            transactionValue: transactionValueTextField.text)
        
        let transactionAlert = UIAlertController(title: "Transaction sent", message: message, preferredStyle: .alert)
        transactionAlert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        present(transactionAlert, animated: true)
    }
}

extension SendTransactionsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }

        if textField == phoneNumberTextField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            validateCountry(partialPhoneNumber: newString.replacingOccurrences(of: " ", with: ""))
            textField.text = newString.apply(pattern: "+### ### ### ####", replacement: "#")
            validateTransaction()
        }
        else if textField == transactionValueTextField {
            if isValidBinaryEntry(string) {
                let newString = (text as NSString).replacingCharacters(in: range, with: string)
                textField.text = newString
                validateTransaction()
            }
        }
        else {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString
            validateTransaction()
        }
        return false
    }
    
    private func isValidBinaryEntry(_ string: String) -> Bool {
        return string.isEmpty || string == "0" || string == "1"
    }
    
    private func validateCountry(partialPhoneNumber: String) {
        let countryPrefix = viewModel.getCountryPrefix(for: partialPhoneNumber)
        countryTextField.text = countryPrefix
        if !countryPrefix.isEmpty {
            viewModel.getExchangeRate(for: countryPrefix) { [weak self] in
                self?.validateTransaction()
            }
        }
    }
    
    private func validateTransaction() {
        DispatchQueue.main.async {
            let transactionPreviewMessage = self.viewModel.getTransactionMessage(recipientName: self.fullNameTextField.text,
                                                                            recipientCountry: self.countryTextField.text,
                                                                            transactionValue: self.transactionValueTextField.text)
            self.transactionPreviewMessageLabel.text = transactionPreviewMessage
            transactionPreviewMessage.isEmpty ?
                self.sendTransactionButton.disable() :
                self.sendTransactionButton.enable()
        }
    }
}
