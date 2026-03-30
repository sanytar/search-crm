import SwiftUI

struct ObjectsView: View {
    @State private var searchText = ""
    @State private var isShowingFilter = false
    @State private var isShowingAddModal = false
    
    @StateObject private var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    @State var selectedChip: ObjectChips = .all
    
    @EnvironmentObject var toast: ToastManager
    
    var body: some View {
        NavigationStack {
                List {
                    Section {
                        ForEach(viewModel.objects ?? []) { object in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("\(object.type.title) • \(object.rooms ?? 0) комн.")
                                            .font(.headline)
                                        Spacer()
                                        
                                    Text("\(object.price ?? 0) ₽")
                                            .font(.headline)
                                            .foregroundStyle(.blue)
                                }
                                HStack {
                                    Text(object.address ?? "")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    Text("\(object.area ?? 0) м²")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                Text(object.isRented ? "Сдана" : "Свободна")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(object.isRented ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                                    .foregroundStyle(object.isRented ? .red : .green)
                                    .clipShape(Capsule())
                            }
                            .contextMenu {
                                    Button {
                                        // действие
                                    } label: {
                                        Label("Редактировать", systemImage: "pencil")
                                    }
                                    
                                    Button {
                                    } label: {
                                        Label("Позвонить", systemImage: "phone")
                                    }
                                    
                                    Button(role: .destructive) {
                                        Task {
                                            if await viewModel.deleteObject(id: object.id) {
                                                toast.show("Объект удален", type: .success)
                                            }
                                        }
                                    } label: {
                                        Label("Удалить", systemImage: "trash")
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
