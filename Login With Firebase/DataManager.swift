import SwiftUI
import Firebase

class DataManager: ObservableObject {
    
    @Published var dogs: [Dog] = []
    
    func fetchDogs() {
        
    }
    
}
