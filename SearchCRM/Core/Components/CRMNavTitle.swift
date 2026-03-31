import SwiftUI

struct CRMNavTitleView: ViewModifier {
    let title: LocalizedStringKey
    let titleMode: NavigationBarItem.TitleDisplayMode
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(titleMode)
    }
}

extension View {
    func crmTitleNav(title: LocalizedStringKey, titleMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self.modifier(CRMNavTitleView(title: title, titleMode: titleMode))
    }
}
