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
            .navigationTitle("objects.title")
            
            .searchable(text: $searchText, prompt: "Поиск по названию")
            
            .toolbar {
                CRMToolbarButton(isOpen: $isShowingFilter, icon: "line.3.horizontal.decrease.circle", position: .topBarLeading)
            
                CRMToolbarButton(isOpen: $isShowingAddModal, icon: "plus", position: .topBarTrailing)
            }
            
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
