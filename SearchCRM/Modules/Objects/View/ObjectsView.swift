import SwiftUI

struct ObjectsView: View {
    @State private var searchText = ""
    @State private var isShowingFilter = false
    @State private var isShowingAddModal = false
    
    @StateObject private var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    @State var selectedChip: ObjectChips = .all
    
    @EnvironmentObject var toast: ToastManager
    
    @State var sortOption: SortObjects = .priceAsc {
        didSet {
            Task {
                print("Запрос ?")
                await viewModel.fetchObjects(sort: sortOption)
                print("Запрос 1")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
                List {
                    Section {
                        ForEach(viewModel.objects ?? [], id: \.id) { object in
                            NavigationLink {
                                ObjectDetailView(property: object)
                            } label: {
                                ObjectRow(object: object) {
                                    Task {
                                        if await viewModel.deleteObject(id: object.id!) {
                                            toast.show("Объект удален", type: .success)
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                        CCRMChips(selectedChip: $selectedChip).onChange(of: selectedChip) {
                            Task { await viewModel.fetchObjects(mainFilter: selectedChip) }
                        }
                    }
                    
                }
                .listStyle(.insetGrouped)
                
                .crmListHeader(
                    searchText: $searchText,
                    title: "objects.title",
                    searchPlaceholder: "Поиск по названию",
                    onAdd: { isShowingAddModal = true } ,
                    onFilter: { isShowingFilter = true },
                    sortOption: $viewModel.sortOption
                )
                .sheet(isPresented: $isShowingFilter) {
                    Text("Фильтры")
                        .presentationDetents([.medium])
                }
                .sheet(isPresented: $isShowingAddModal) {
                    AddObjectView(viewModel: viewModel)
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
