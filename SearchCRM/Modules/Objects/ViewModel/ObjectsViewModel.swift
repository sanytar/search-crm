import SwiftUI
import Combine
import Supabase

class ObjectsViewModel: ObservableObject {
    @Published var object: PropertyModel = PropertyModel(type: .apartment, price: 0, rooms: 0, address: "")
    
    @Published var isLoading: Bool = false
    
    
    func fetchObjects() async {
        isLoading = true
        
        do {
            try await supabase
                .from("objects")
                .select("id, type, price, rooms, address")
                .execute()
                .value
        } catch let error {
            print(error)
        }
        isLoading = false
    }
    
}
