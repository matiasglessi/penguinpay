//
//  UIButton+Enable.swift
//  PenguinPay
//
//  Created by Matias Glessi on 20/10/2021.
//

import UIKit

extension UIButton {
    func enable() {
        isEnabled = true
        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
    }
    
    func disable() {
        isEnabled = false
        setTitleColor(.gray, for: .normal)
        backgroundColor = .lightGray
    }
}
