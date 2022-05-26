//
//  LoginedView.swift
//  iOSFrameWork
//
//  Created by Wynne Tran on 2022-05-25.
//

import Foundation

@available(iOS 13.0, *)
public class LoginViewModel: NSObject,  ObservableObject {
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var storeCredentialsNext = false
  
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        APIService.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
         showProgressView = false
            switch result {
            case .success:
                if storeCredentialsNext {
                    if KeychainStorage.saveCredentials(credentials) {
                        storeCredentialsNext = false
                    }
                }
                completion(true)
            case .failure(let authError):
                credentials = Credentials()
                error = authError
                completion(false)
            }
        }
    }
}