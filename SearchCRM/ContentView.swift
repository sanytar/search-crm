import SwiftUI
import Supabase
import Supabase

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    func handleIncomingURL(_ url: URL) async {
        do {
            try await supabase.auth.handle(url)
            print("✅ URL обработан, сессия сохранена")
        } catch {
            print("❌ Ошибка обработки URL: \(error)")
        }
    }
    
    var body: some View {
        Group {
//            if appState.isAuthenticated {
            
            TabView  {
                ForEach(AppTab.allCases) { tab in
                    tab.destination
                        .tabItem {
                            Label(tab.title, systemImage: tab.icon)
                        }
                }
            }
            
//            } else {
//                AuthView()
//            }
        }
        
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
//    ContentView()
}
