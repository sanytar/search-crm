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
            .crmListHeader(
                searchText: $searchText,
                title: "tenants.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isAddModalOpen = true},
                onFilter: {isShowingFilter = true }
            )
        }
    }
}
