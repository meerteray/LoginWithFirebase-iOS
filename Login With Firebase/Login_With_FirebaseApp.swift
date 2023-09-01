import SwiftUI
import Firebase

@main
struct Login_With_FirebaseApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
