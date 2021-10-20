//
//  SessionMock.swift
//  PenguinPayTests
//
//  Created by Matias Glessi on 20/10/2021.
//

import Foundation
@testable import PenguinPay

class SessionMock: Session {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}
