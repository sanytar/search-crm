import SwiftUI

struct CRMNavTitleView: ViewModifier {
    let title: String
    let titleMode: NavigationBarItem.TitleDisplayMode
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(titleMode)
    }
}

extension View {
    func crmTitleNav(title: String, titleMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self.modifier(CRMNavTitleView(title: title, titleMode: titleMode))
    }
}
