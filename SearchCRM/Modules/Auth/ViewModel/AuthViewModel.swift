import Foundation
import Supabase
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorText: String?
    
    func login(email: String, password: String) async {
        isLoading = true
        errorText = nil
        
        do {
            let response = try await supabase.auth.signIn(email: email, password: password)
            print("Успешно \(response)")
        } catch let error {
            print("Ошибка \(error)")
            errorText = "Ошибочка, епта"
        }
        isLoading = false
    }
    
    func signUp(email: String, password: String) async {
        isLoading = true
        errorText = nil
        
        do {
            
            try await supabase.auth.signUp(email: email, password: password)
        } catch {
            errorText = "Ошибка регистрации: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func logout() {
        // выход из приложения
    }
}
