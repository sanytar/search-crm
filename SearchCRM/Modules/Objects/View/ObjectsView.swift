import SwiftUI

struct ObjectsView: View {
    @State private var searchText = ""
    @State private var isShowingFilter = false
    @State private var isShowingAddModal = false
    
    @StateObject private var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(viewModel.objects ?? []) { object in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(object.type.title) • \(object.rooms) комн.")
                                    .font(.headline)
                                Spacer()
                                Text("\(object.price) ₽")
                                    .font(.headline)
                                    .foregroundStyle(.blue)
                            }
                            HStack {
                                Text(object.address)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("\(object.area ?? 0) м²")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
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
                .overlay {
                    if viewModel.objects?.isEmpty == true && !viewModel.isLoading {
                        CRMEmptyList(title: "Нет объектов", icon: "building.2")
                    }
                }
            }
            
        
        
    }
}

#Preview {
    ObjectsView()
}
