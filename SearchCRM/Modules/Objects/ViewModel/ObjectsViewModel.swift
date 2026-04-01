import SwiftUI
import Combine
import Supabase


@MainActor
class ObjectsViewModel: ObservableObject {
    @Published var object: PropertyModel
    @Published var objects: [PropertyModel]? = nil
    
    @Published var isLoading: Bool = false
    
    @Published var sortOption: SortObjects = .priceDesc {
        didSet {
            Task { await fetchObjects(sort: sortOption) }
        }
    }
    
    var isEditing: Bool = false
    
    init() {
        self.object = PropertyModel(type: .apartment, isRented: false)
    }
    
    init(property: PropertyModel) {
            self.object = property
            self.isEditing = true
    }
    
    func fetchObjects(mainFilter: ObjectChips = .all, sort: SortObjects = .priceAsc) async {
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
            
                    let ascending: Bool
                    let column: String
            
                    switch sort {
                            case .priceDesc: column = "price";     ascending = false
                            case .priceAsc:  column = "price";     ascending = true
                            case .areaDesc:  column = "area";      ascending = false
                            case .areaAsc:   column = "area";      ascending = true
                            case .freeFirst: column = "is_rented"; ascending = true
                    }
            
            objects = try await query
                        .order(column, ascending: ascending)
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
    
    func save() async -> Bool {
            do {
                if isEditing {
                    await updateObject()
                } else {
                    await createObject()
                
                }
            } catch let error {
                print(error)
                return false
            }
        return true
            
        }
    
    func updateObject() async {
        isLoading = true
        
        do {
            try await supabase
                .from("properties")
                .update(object)
                .eq("id", value: object.id!)
                .execute()
            
            await fetchObjects()
        } catch {
            print(error)
        }
        
        isLoading = false
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

