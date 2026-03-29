import SwiftUI
import Supabase

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: AppTab = .objects
    
//    save session
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
            
            if appState.isLoading {
                ZStack {
                            Color(.systemBackground).ignoresSafeArea()
                            ProgressView()
                        }
            } else if appState.isAuthenticated {
                TabView(selection: $selectedTab,)  {
                    ForEach(AppTab.allCases) { tab in
                        tab.destination
                            .tabItem {
                                Label(tab.title, systemImage: tab.icon)
                            }.tag(tab)
                    }
                }.onChange(of: selectedTab) {
                    Helpers.doFeedback(type: .light)
                }
            } else {
                AuthView()
            }
        }
        .preferredColorScheme(appState.theme.colorScheme)
        
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
