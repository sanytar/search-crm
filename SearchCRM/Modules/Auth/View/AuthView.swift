import SwiftUI

struct AuthView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    
    @State private var isEmailSending: Bool = false
    
    @State private var shakeOffset: CGFloat = 0
    
    
    @StateObject private var viewModel = AuthViewModel()
    
    func shake() {
        withAnimation(.easeInOut(duration: 0.06).repeatCount(4, autoreverses: true)) {
            shakeOffset = 10
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                shakeOffset = 0
        }
    }
    
    
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
                        Text("Начните работу в SearchCRM")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Авторизуйтесь для начала работы")
                            
                    }
                    
                    if !viewModel.isEmailSending {
                        VStack(spacing: 15) {
                            VStack() {
                                CRMInput(title: "Электронная почта", placeholder: "example@example.com", text: $login, type: .emailAddress)
                                
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
                                        
                                        await viewModel.login(email: login)
                                        
                                        if viewModel.errorText != nil {
                                            shake()
                                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                                        }
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
                                .offset(x: shakeOffset)
                                    
                            }
                            
                            
                            
                        }
                    } else {
                        Text("Ссылка для входа уже на вашей почте ✉️")
                            .bold()
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
