import Supabase
import SwiftUI
import Foundation
import Combine

@MainActor
class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = true
    
    @AppStorage("appTheme") var theme: AppColor = .system
    // В AppState добавляешь
    
    init() {
        Task {
            
            print("Запускаем , пытаемся слушать")
            // Проверяем текущую сессию при старте
            if let _ = try? await supabase.auth.session {
                print("Сессия найдена")
                isAuthenticated = true
            }
            
            isLoading = false            
            
            for await (event, session) in await supabase.auth.authStateChanges {
                switch event {
                case .signedIn:
                    isAuthenticated = true
                case .signedOut:
                    isAuthenticated = false
                default:
                    break
                }
            }
        }
    }
}
