import SwiftUI

struct LandlordsView: View {
    @State private var isAddModalOpen: Bool = false
    @State private var isShowingFilter: Bool = false
    
    @StateObject var viewModel: LandlordViewModel = LandlordViewModel()
    
    var body: some View {
        NavigationStack {
            CRMItemList(landlords: viewModel.landlords)
            .crmProgress(isShowing: viewModel.isLoading)
            .crmListHeader(
                searchText: $viewModel.searchQuery,
                title: "landlords.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isAddModalOpen = true },
                onFilter: {isShowingFilter = true }
            )
            .sheet(isPresented: $isAddModalOpen) {
                LandlordCreateView(viewModel: viewModel)
            }
            .sheet(isPresented: $isShowingFilter) {
                Text("Фильтры не реализованы")
            }
            .task {
                await viewModel.fetchLandlords()
            }
        }
    }
}

#Preview {
    LandlordsView()
}
