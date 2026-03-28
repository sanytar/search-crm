import SwiftUI

struct TenantsView: View {
    @State private var isAddModalOpen: Bool = false
    @State private var isShowingFilter: Bool = false
    
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            List {
                Text("Арендатор")
                Text("Арендатор")
                Text("Арендатор")
                Text("Арендатор")
            }
            .toolbar {
                CRMToolbarButton(isOpen: $isAddModalOpen, icon: "plus", position: .topBarTrailing)
                CRMToolbarButton(isOpen: $isShowingFilter, icon: "line.3.horizontal.decrease.circle", position: .topBarLeading)
            }
            .navigationTitle("tenants.title")
            .searchable(text: $searchText, prompt: "Поиск по названию")
        }
    }
}
