import SwiftUI
import Supabase

struct SettingsView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @State private var isShowingLogoutAlert: Bool = false
    
    var body: some View {
        NavigationStack {

                List {
                    Section {
                        NavigationLink(destination: ProfileView()) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text("settings.profile.title")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .frame(minHeight: 60)
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: AppearanceView()) {
                            HStack {
                                Image(systemName: "sun.max.fill")
                                Text("settings.appearance")
                            }
                            
                        }
                    }
                    
                    Section {
                        Button("settings.logout") {
                            isShowingLogoutAlert.toggle()
                        }
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                        .alert("settings.logout", isPresented: $isShowingLogoutAlert) {
                            Button("settings.logout", role: .destructive) {
                                Task {
                                    await viewModel.logout()
                                }
                            }
                            Button("settings.logout.cancel", role: .cancel) {
                                
                            }
                        } message: {
                            Text("settings.logout.message")
                        }
                    }
                    
                }
                .navigationTitle(Text("settings.title"))
                .navigationBarTitleDisplayMode(.large)
            
        }
    }
}

#Preview {
    SettingsView()
}
