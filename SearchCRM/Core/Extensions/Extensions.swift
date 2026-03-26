import SwiftUI

struct CRMInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct CRMToolbarModifier: ViewModifier {
    @Binding var isOpen: Bool
    let icon: String
    let position: ToolbarItemPlacement
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: position) {
                    Button {
                        isOpen.toggle()
                    } label: {
                        Image(systemName: icon)
                    }
                }
            }
    }
}

extension View {
    func crmInputStyle() -> some View {
        self.modifier(CRMInputModifier())
    }
}
