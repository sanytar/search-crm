import SwiftUI
import Combine

struct LandlordsView: View {
    @State private var isAddModalOpen: Bool = false
    @State private var isShowingFilter: Bool = false
    
    @StateObject var viewModel: LandlordViewModel = LandlordViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.landlords ?? []) { item in
                    VStack(alignment: .leading) {
                            Text(item.firstName)
                                .font(.headline)
                            Text(item.phone)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .crmListHeader(
                searchText: $viewModel.searchQuery,
                title: "landlords.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isAddModalOpen = true},
                onFilter: {isShowingFilter = true }
            )
            .sheet(isPresented: $isAddModalOpen) {
                LandlordCreateView(viewModel: viewModel)
            }
            .task() {
                await viewModel.fetchLandlords()
            }
        }
    }
}

