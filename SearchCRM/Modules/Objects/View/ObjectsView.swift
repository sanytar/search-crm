import SwiftUI

struct ObjectsView: View {
    @State private var searchText = ""
    @State private var isShowingFilter = false
    @State private var isShowingAddModal = false
    
    @StateObject private var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Text("Объект")
                Text("Объект")
                Text("Объект")
                Text("Объект")
                Text("Объект")
            }
            .crmListHeader(
                searchText: $searchText,
                title: "objects.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isShowingAddModal = true } ,
                onFilter: { isShowingFilter = true }
            )
            .sheet(isPresented: $isShowingFilter) {
                Text("Фильтры")
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $isShowingAddModal) {
                AddObjectView()
            }
            .task {
                await viewModel.fetchObjects()
            }
        }
        
    }
}
