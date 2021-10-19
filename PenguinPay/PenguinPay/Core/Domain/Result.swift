//
//  Result.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}


