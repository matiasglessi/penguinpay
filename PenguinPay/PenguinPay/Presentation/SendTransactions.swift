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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.delegate = self
        transactionValueTextField.delegate = self
    }
    
    
}

extension SendTransactions: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            if let text = textField.text {
                validateCountry(partialPhoneNumber: text + string)
            }
        }
        return true
    }
    
    private func validateCountry(partialPhoneNumber: String) {
        if partialPhoneNumber.starts(with: "254") {
            countryTextField.text = "NGN"
        }
    }
    
}

