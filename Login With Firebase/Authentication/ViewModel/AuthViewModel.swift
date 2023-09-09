import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
     print("SignIn")
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
       print("Create User")
    }
    
    func signOut() {
        
    }
    
    func fetchUser() async {
        
    }
}
