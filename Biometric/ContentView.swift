import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
  @EnvironmentObject  var authentication: Authentication
  var body: some View {
        NavigationView {
            VStack {
                Text("Authorized..  You are in!!")
                    .font(.largeTitle)
                Image("Inside")
            }
                .padding()
                .navigationTitle("My Secure App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log out") {
                        authentication.updateValidation(success: false)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  @available(iOS 13.0.0, *)
  static var previews: some View {
    if #available(iOS 14.0, *) {
      ContentView()
    } else {
      // Fallback on earlier versions
    }
    }
}


