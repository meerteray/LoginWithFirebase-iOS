import SwiftUI
import Firebase

class DataManager: ObservableObject {
    
    @Published var dogs: [Dog] = []
    
    func fetchDogs() {
        dogs.removeAll()
        
        let database = Firestore.firestore()
        let ref = database.collection("Dogs")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
        }
    }
    
}
