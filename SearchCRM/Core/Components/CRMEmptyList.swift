import SwiftUI

struct CRMEmptyList: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack() {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundStyle(.tertiary)
            Text(title)
                .font(.headline)
            Text("Нажмите + чтобы добавить")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        
    }
}

#Preview {
    CRMEmptyList(title: "Товаров нет", icon: "cart")
}