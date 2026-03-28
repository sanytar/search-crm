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
            .toolbar {
                CRMToolbarButton(isOpen: $isAddModalOpen, icon: "plus", position: .topBarTrailing)
                CRMToolbarButton(isOpen: $isShowingFilter, icon: "line.3.horizontal.decrease.circle", position: .topBarLeading)
            }
            .sheet(isPresented: $isAddModalOpen) {
                LandlordCreateView(viewModel: viewModel)
            }
            .navigationTitle("landlords.title")
            .searchable(text: $viewModel.searchQuery, prompt: "Поиск по названию")
            .task() {
                await viewModel.fetchLandlords()
            }
        }
    }
}

