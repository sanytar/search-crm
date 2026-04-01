import SwiftUI
import Combine
import Supabase

@MainActor
class LandlordViewModel: ObservableObject {
    @Published var isLoading = false
    // заполняемый арендодатель
    @Published var landlord: NewLandlordModel = NewLandlordModel(firstName: "", phone: "")
    // список арендодателей
    @Published var landlords: [LandlordModel]? = nil
    
    @Published var searchQuery: String = ""
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] query in
                Task {
                    await self?.searchLandlords()
                }
            }
            .store(in: &cancellables)
    }
    
        
    func fetchLandlords() async {
        isLoading = true
        
        do {
           landlords = try await supabase
                .from("landlords")
                .execute()
                .value
            
        print(landlords)
        } catch let error {
            print(error)
        }
        
        isLoading = false
    }
    
    func createLandlord() async -> LandlordModel? {
        isLoading = true
        
        do {
            let response: LandlordModel = try await supabase
                .from("landlords")
                .insert(landlord)
                .select()
                .single()
                .execute()
                .value
            
//            await fetchLandlords()
            return response
        } catch let error {
            print(error)
        }
        
        isLoading = false
        return nil
    }
    
    func searchLandlords() async {
        do {
            landlords = try await supabase
                .from("landlords")
                .select()
                .ilike("first_name", value: "%\(searchQuery)%")
                .execute()
                .value
        } catch {
            print(error)
        }
    }
}
