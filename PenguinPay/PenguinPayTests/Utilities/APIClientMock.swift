//
//  APIClientMock.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import Foundation
@testable import PenguinPay

class APIClientMock: APIClient {
    
    var result: Result<[String : Any]> = .success([:])
    
    func get(from url: URL?, completion: @escaping (Result<[String : Any]>) -> Void) {
        completion(result)
    }
}
