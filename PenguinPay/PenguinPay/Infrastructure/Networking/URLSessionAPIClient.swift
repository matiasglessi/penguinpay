//
//  URLSessionAPIClient.swift
//  PenguinPay
//
//  Created by Matias Glessi on 19/10/2021.
//

import Foundation

enum APIClientError: Error, Equatable, CaseIterable {
    case missingData
    case invalidURL
    case unknown
}

class URLSessionAPIClient: APIClient {
    private let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    func get(from url: URL?, completion: @escaping (Result<[String:Any]>) -> Void) {
        guard let url = url else {
            completion(.failure(APIClientError.invalidURL))
            return
        }
        
        session.loadData(from: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(APIClientError.missingData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let jsonData = convertedJsonIntoDict["rates"] as? [String : Any] {
                        completion(.success(jsonData))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
