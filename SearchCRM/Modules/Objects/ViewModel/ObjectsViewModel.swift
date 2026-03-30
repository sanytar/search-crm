import SwiftUI
import Combine
import Supabase

class ObjectsViewModel: ObservableObject {
    @Published var object: PropertyModel = PropertyModel(type: .apartment, price: 0, rooms: 0, address: "", isRented: false)
    @Published var objects: [PropertyModel]? = nil
    
    @Published var isLoading: Bool = false
    
    
    func fetchObjects(mainFilter: ObjectChips = .all) async {
        isLoading = true
        
        do {
            var query = supabase
                        .from("properties")
                        .select()
                    
                    switch mainFilter {
                    case .all:
                        break // без фильтра
                    case .isNotRented:
                        query = query.eq("is_rented", value: false)
                    case .isNotLandlord:
                        query = query.is("landlord_id", value: .none)
                    }
            
            objects = try await query
                        .execute()
                        .value
        } catch let error {
            print(error)
        }
        isLoading = false
    }
    
    func createObject() async {
        isLoading = true
        
        do {
            try await supabase
                .from("properties")
                .insert(object)
                .execute()
                .value
            await fetchObjects()
        } catch let error {
            print(error)
        }
        
        isLoading = false
    }
    
}
