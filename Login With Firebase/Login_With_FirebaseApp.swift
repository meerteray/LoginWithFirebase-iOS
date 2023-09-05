import SwiftUI
import FirebaseCore

enum Route: Hashable {
    case login
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application:  UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

class Coordinator: ObservableObject {
    @Published var path = [Route]()
}


@main
struct Login_With_FirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @ObservedObject var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            Text("Hoş Geldiniz")
                        }
                    }
                
            }.environmentObject(coordinator)
        }
    }
}
