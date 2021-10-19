//
//  APIClient.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

protocol APIClient {
    func get(from url: URL?, completion: @escaping (Result<[String:Any]>) -> Void)
}
