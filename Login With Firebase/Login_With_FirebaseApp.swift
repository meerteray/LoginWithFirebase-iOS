import SwiftUI

@main
struct Login_With_FirebaseApp: App {
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
