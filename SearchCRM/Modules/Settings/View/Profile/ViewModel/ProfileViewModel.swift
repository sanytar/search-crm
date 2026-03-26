import SwiftUI
import Supabase
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var profile: ProfileModel?
    @Published var errorText: String?
    
    @Published var roles: [Role] = []
    
    func fetchProfile() async  {
        isLoading.toggle()
        
        let query = """
            id,
            first_name,
            last_name,
            middle_name,
            gender,
            birth_date,
            passport_issued_date,
            passport_series,
            passport_number,
            passport_issued_by,
            registration_address,
            living_address,
            phone,
            agency,
            roles(id, name)
        """
        
        do {
            let userId = try await supabase.auth.session.user.id
            
            profile = try await supabase
                .from("profiles")
                .select(query)
                .eq("id", value: userId)
                .single()
                .execute()
                .value
            
            isLoading.toggle()
        } catch let error {
            print(error)
        }
    }
    
    func changeProfile() async {
        do {
            
        } catch let error {
            
        }
    }
}
