import SwiftUI

struct AuthView: View {
   @State private var login: String = ""
   @State private var password: String = ""
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                    .onTapGesture {
                                    hideKeyboard()
                                }
                
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Добро пожаловать !")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Авторизуйтесь для начала")
                    }
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 10) {
                            TextField("Логин", text: $login)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 18)
                                .background(.white)
                                .cornerRadius(12)
                            
                            SecureField("Пароль", text: $password)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 18)
                                .background(.white)
                                .cornerRadius(12)
                            
                            HStack {
                                Button(action: {
                                    print("Восстановление доступа началось")
                                }) {
                                    Text("Забыли пароль ?")
                                        .font(.footnote)
                                }
                                Spacer()
                            }
                            
                        }
                        
                        VStack(spacing: 15) {
                            HStack {
                                if viewModel.errorText != nil {
                                    Text(viewModel.errorText ?? "deafult")
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                            }
                            
                            Button(action: {
                                Task {
                                    await viewModel.login(email: login, password: password)
                                }
                            }) {
                                
                                ZStack {
                                    Text("Войти")
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .opacity(viewModel.isLoading ? 0 : 1)
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .tint(.white)
                                            .controlSize(.small)
                                    }
                                }
                                
                                
                                
                            }
                            .background(viewModel.isLoading ? Color.blue.opacity(0.7) : Color.blue)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .cornerRadius(12)
                            .disabled(viewModel.isLoading)
                            
                            HStack() {
                                Text("Нет аккаунта ?")
                                NavigationLink(destination: SignUpView()) {
                                    Text("Зарегистрироваться")
                                        .fontWeight(.bold)
                                }
                            }
                                
                        }
                        
                        
                        
                    }
                }
                .padding(20)
            }
        }
        
        
        
        
    }
}

#Preview {
    AuthView()
}
