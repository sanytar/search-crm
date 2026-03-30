import SwiftUI
import Combine
import Supabase

class ObjectsViewModel: ObservableObject {
    @Published var object: newPropertyModel = newPropertyModel(type: .apartment, isRented: false)
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
                        break
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
    
    func createObject() async -> Bool {
        isLoading = true
            
            do {
                let created: PropertyModel = try await supabase
                    .from("properties")
                    .insert(object)
                    .select()
                    .single()
                    .execute()
                    .value
                print(created)
                await MainActor.run {
                    withAnimation {
                        objects?.append(created)
                    }
                }
                
                isLoading = false
                return true
            } catch let error {
                print(error)
                isLoading = false
                return false
            }
    }
    
    func deleteObject(id: UUID) async -> Bool {
        do {
            print(id)
            try await supabase
                .from("properties")
                .delete()
                .eq("id", value: id)
                .execute()
            
            await MainActor.run {
                withAnimation {
                    objects?.removeAll { $0.id == id }
                }
            }
            
        // TODO: подумать как удалять просто на фронте после статуса ОК с бэка
            return true
        } catch {
            print("Ошибка удаления: \(error)")
        }
        return false
    }
   
    
}

