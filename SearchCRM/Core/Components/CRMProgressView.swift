import SwiftUI

struct CRMProgressView: ViewModifier {
    var isShowing: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isShowing {
                    ProgressView()
                }
            }
    }
}

extension View {
    func crmProgress(isShowing: Bool) -> some View {
        modifier(CRMProgressView(isShowing: isShowing))
    }
}
