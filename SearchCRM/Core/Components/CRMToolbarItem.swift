import SwiftUI

struct CRMToolbarButton: ToolbarContent {
    @Binding var isOpen: Bool
    
    let icon: String
    let position: ToolbarItemPlacement
    
    var body: some ToolbarContent {
        ToolbarItem(placement: position) {
            Button {
                isOpen.toggle()
            } label: {
                Image(systemName: icon)
            }
        }
    }
}
