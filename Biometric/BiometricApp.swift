//
//  BiometricApp.swift
//  Biometric
//
//  Created by Wynne Tran on 2022-05-25.
//

import SwiftUI

@main
struct MySecureApp_App: App {
    @StateObject var authentication = Authentication()
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
