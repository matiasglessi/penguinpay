//
//  ViewController.swift
//  PenguinPay
//
//  Created by Matias Glessi on 18/10/2021.
//

import UIKit

class SendTransactions: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var transactionValueTextField: UITextField!
    
    @IBOutlet weak var transactionPreviewMessage: UILabel!

    private var viewModel: SendTransactionsViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SendTransactionsViewModel(getCountryService: DefaultGetCountryService())
        phoneNumberTextField.delegate = self
        transactionValueTextField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenTap(_:))))
    }
    
    @objc func screenTap(_ sender: UITapGestureRecognizer? = nil) {
        fullNameTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        transactionValueTextField.resignFirstResponder()
    }
}

extension SendTransactions: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if textField == phoneNumberTextField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            validateCountry(partialPhoneNumber: newString.replacingOccurrences(of: " ", with: ""))
            textField.text = newString.apply(pattern: "+### ### ### ####", replacement: "#")
            return false
        }
        
        return true
    }
    
    private func validateCountry(partialPhoneNumber: String) {
        countryTextField.text = viewModel.getCountryPrefix(for: partialPhoneNumber)
    }
}
