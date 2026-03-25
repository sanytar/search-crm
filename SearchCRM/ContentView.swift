import SwiftUI

struct ContentView: View {
    var body: some View {
//        TabView {
//            ForEach(AppTab.allCases) { tab in
//                tab.destination
//                    .tabItem {
//                        Label(tab.title, systemImage: tab.icon)
//                    }
//            }
//
//        }
        
        AuthView()
        
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
