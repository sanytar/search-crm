import SwiftUI
import Combine

class ToastManager: ObservableObject {
    @Published var message: String = ""
    @Published var type: ToastType = .success
    @Published var isShowing: Bool = false
    
    enum ToastType {
        case success, error
        
        var color: Color {
            switch self {
            case .success: return .green
            case .error: return .red
            }
        }
        
        var icon: String {
            switch self {
            case .success: return "checkmark.circle.fill"
            case .error: return "xmark.circle.fill"
            }
        }
    }
    
    func show(_ message: String, type: ToastType = .success) {
        withAnimation(.spring()) {
            self.message = message
            self.type = type
            self.isShowing = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.spring()) {
                self.isShowing = false
            }
        }
    }
}

struct ToastView: View {
    @EnvironmentObject var toast: ToastManager
    
    var body: some View {
        VStack {
            Spacer()
            if toast.isShowing {
                HStack(spacing: 12) {
                    Image(systemName: toast.type.icon)
                        .foregroundColor(toast.type.color)
                    Text(toast.message)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(.ultraThinMaterial)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.1), radius: 10)
                .padding(.bottom, 32)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
