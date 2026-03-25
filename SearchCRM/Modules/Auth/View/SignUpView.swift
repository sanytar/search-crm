import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Регистрация")
                .font(.largeTitle)
                .bold()
            Text("Заполните поля для регистрации")
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    SignUpView()
}
