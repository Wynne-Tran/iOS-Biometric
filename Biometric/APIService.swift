//
//  APIService.swift
//  iOSFrameWork
//
//  Created by Wynne Tran on 2022-05-25.
//

import Foundation
class APIService {
    static let shared = APIService()

  @available(iOS 13.0, *)
  func login(credentials: Credentials,
               completion: @escaping (Result<Bool,Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if credentials.password == "password" {
                completion(.success(true))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}
