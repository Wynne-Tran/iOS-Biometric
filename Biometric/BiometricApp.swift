//
//  BiometricApp.swift
//  Biometric
//
//  Created by Wynne Tran on 2022-05-25.
//

import SwiftUI

@main
struct BiometricApp: App {
    let authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
              ContentView()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}

