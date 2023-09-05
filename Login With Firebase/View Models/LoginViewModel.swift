import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func login1(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            
            guard result != nil, error == nil else {
                return
            }
        }
    }
    
}
