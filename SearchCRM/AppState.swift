import Supabase
import Foundation
import Combine

@MainActor
class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init() {
        Task {
            
            print("Запускаем , пытаемся слушать")
            // Проверяем текущую сессию при старте
            if let _ = try? await supabase.auth.session {
                print("Сессия найдена")
                isAuthenticated = true
            }
            
            // Слушаем изменения авторизации
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
