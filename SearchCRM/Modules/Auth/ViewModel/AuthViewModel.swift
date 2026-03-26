import Foundation
import Supabase
import Combine
import UIKit

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorText: String?
    
    @Published var isEmailSending: Bool = false
    
    func login(email: String) async {
        isLoading = true
        errorText = nil
        
        do {
            let response = try await supabase.auth.signInWithOTP(
                email: email,
                redirectTo: URL(string: "mysearchcrm://login"),
                shouldCreateUser: true
              )
            isEmailSending = true
//            print(response)
        }  catch let error as AuthError {
            
            switch error {
            case .api(let message, let errorCode, _, _):
                switch errorCode.rawValue {
                case "validation_failed":
                    errorText = "Неверный формат email"
                case "over_email_send_rate_limit":
                    errorText = "Превышен лимит запросов, попробуйте позже"
                default:
                    errorText = message
                }
            default:
                errorText = "Что-то пошло не так"
            }
        } catch {
            errorText = "Нет соединения с сервером"
        }

        isLoading = false
    }
    
    func logout() async {
        do {
            let response = try await supabase.auth.signOut()
            print("Успех \(response)")
        } catch let error {
            print("Ошибка \(error)")
        }
        
    }
}
