import SwiftUI

struct LandlordsView: View {
    @State private var isAddModalOpen: Bool = false
    @State private var isShowingFilter: Bool = false
    
    @StateObject var viewModel: LandlordViewModel = LandlordViewModel()
    
    @State var sortOption: SortMenuList = .areaAsc
    
    var body: some View {
        NavigationStack {
            CRMItemList(landlords: viewModel.landlords, isLoading: viewModel.isLoading)
            .crmProgress(isShowing: viewModel.isLoading)
            .crmListHeader(
                searchText: $viewModel.searchQuery,
                title: "landlords.title",
                searchPlaceholder: "Поиск по названию",
                onAdd: { isAddModalOpen = true },
                onFilter: {isShowingFilter = true },
                sortOption: $sortOption
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
