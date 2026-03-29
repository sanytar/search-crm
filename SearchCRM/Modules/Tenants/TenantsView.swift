import SwiftUI

struct TenantsView: View {
    @State private var isAddModalOpen: Bool = false
    @State private var isShowingFilter: Bool = false
    
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            
            List {
                
            }
            .crmListHeader(
                searchText: $searchText,
                title: "tenants.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isAddModalOpen = true },
                onFilter: {isShowingFilter = true }
            )
            .sheet(isPresented: $isAddModalOpen) {
//                открыть добавление арендатора
            }
            .sheet(isPresented: $isShowingFilter) {
                Text("Фильтры не реализованы")
            }
            .overlay {
                CRMEmptyList(title: "Нет арендаторов", icon: "building.2")
            }
        }
    }
}

#Preview {
    TenantsView()
}
