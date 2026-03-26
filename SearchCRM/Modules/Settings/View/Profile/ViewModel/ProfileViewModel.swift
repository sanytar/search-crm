import SwiftUI
import Supabase
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var profile: ProfileModel?
    @Published var errorText: String?
    
    @Published var roles: [Role] = []
    
    @Published var editingProfile: ProfileModel? = nil
    
    func startEditing() {
            editingProfile = profile
    }
        
    func cancelEditing() {
        editingProfile = nil
    }
    
    func saveProfile() async {
        guard let editing = editingProfile else { return }
        
        isLoading = true
        let update = ProfileUpdate(
                    firstName: editing.firstName,
                    lastName: editing.lastName,
                    middleName: editing.middleName,
                    gender: editing.gender,
                    birthDate: editing.birthDate,
                    passportIssuedDate: editing.passportIssuedDate,
                    passportSeries: editing.passportSeries,
                    passportNumber: editing.passportNumber,
                    passportIssuedBy: editing.passportIssuedBy,
                    registrationAddress: editing.registrationAddress,
                    livingAddress: editing.livingAddress,
                    phone: editing.phone,
                    agency: editing.agency
                )
        
        do {
            try await supabase
                .from("profiles")
                .update(update)
                .eq("id", value: editing.id)
                .execute()
            
            profile = editing
            editingProfile = nil
        } catch {
            errorText = "Ошибка сохранения"
            print(error)
        }
        
        isLoading = false
    }
    
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
            roles(id, name_ru, name_en)
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
