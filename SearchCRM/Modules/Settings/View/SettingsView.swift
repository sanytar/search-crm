import SwiftUI
import Supabase

struct SettingsView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @State private var isShowingLogoutAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Настройки")
                    .font(.largeTitle)
                    .bold()
                
            }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            // TODO: Вынести растягивание VStack в расширения ( Extensions ), чтобы переиспользовать в др.местах
            Spacer()
            Button("Выйти") {
                isShowingLogoutAlert.toggle()
            }
            .foregroundStyle(.red)
            .padding()
            .alert("Выход", isPresented: $isShowingLogoutAlert) {
                Button("Выход", role: .destructive) {
                    Task {
                        await viewModel.logout()
                    }
                }
                Button("Отмена", role: .cancel) {
                    
                }
            } message: {
                Text("Вы уверены что хотите выйти ?")
            }
            
        }
    }
}

#Preview {
    SettingsView()
}
