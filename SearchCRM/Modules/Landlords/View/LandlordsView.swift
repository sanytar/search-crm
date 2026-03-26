import SwiftUI

struct LandlordsView: View {
    @State private var isAddModalOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                CRMToolbarButton(isOpen: $isAddModalOpen, icon: "plus", position: .topBarTrailing)
            }
            
        }
    }
}

