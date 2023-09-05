import Foundation
import Firebase

enum FBError: Error, Identifiable {
    case error(String)
    
    var id: UUID {
        UUID()
    }
    
    var errorMessage: String {
        
        switch self {
        case .error(let message):
            return message
        }
    }
}

class SignUpViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, FBError>) ->Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
           
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
            
        }
    }
}
