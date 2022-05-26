import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct LoginView: View {
  @StateObject private var loginVM = LoginViewModel()
  @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            Text("My Secure App")
                .font(.largeTitle)
            TextField("Email Address", text: $loginVM.credentials.email)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $loginVM.credentials.password)
            if loginVM.showProgressView {
                ProgressView()
            }
            Button("Log in") {
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginVM.loginDisabled)
            .padding(.bottom,20)
            if authentication.biometricType() != .none {
                Button {
                    authentication.requestBiometricUnlock { (result:Result<Credentials, Authentication.AuthenticationError>) in
                        switch result {
                        case .success(let credentials):
                            loginVM.credentials = credentials
                            loginVM.login { success in
                                authentication.updateValidation(success: success)
                            }
                        case .failure(let error):
                            loginVM.error = error
                        }
                    }
                } label: {
                    Image(systemName: authentication.biometricType() == .face ? "faceid" : "touchid")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            Image("LaunchScreen")
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            Spacer()
        }
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            if error == .credentialsNotSaved {
                return Alert(title: Text("Credentials Not Saved"),
                             message: Text(error.localizedDescription),
                             primaryButton: .default(Text("OK"), action: {
                                loginVM.storeCredentialsNext = true
                             }),
                             secondaryButton: .cancel())
            } else {
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
  @available(iOS 13.0.0, *)
  static var previews: some View {
    if #available(iOS 14.0, *) {
      LoginView()
        .environmentObject(Authentication())
    } else {
      // Fallback on earlier versions
    }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
