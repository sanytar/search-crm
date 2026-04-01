import SwiftUI
import Foundation

struct LandlordsSearchList: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedLandlordId: LandlordModel?
    @StateObject var viewModel: LandlordViewModel = LandlordViewModel()
    
    
    @State private var isCreateOpen: Bool = false
    
    @State private var createdLandlord: LandlordModel? = nil
    @State private var showAssignAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                        isCreateOpen = true
                    } label: {
                        Label("landlord.new", systemImage: "plus")
                    }
                    
                ForEach(viewModel.landlords ?? [], id: \.id) { item in
                    Button {
                        selectedLandlordId = item
                        dismiss()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.firstName)
                                .font(.headline)
                            Text(item.phone)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $isCreateOpen) {
                LandlordCreateView(viewModel: viewModel) { landlord in
                    createdLandlord = landlord
                    showAssignAlert = true
                }
            }
            .alert("landlords.appoint", isPresented: $showAssignAlert) {
                Button("general.yes") {
                    selectedLandlordId = createdLandlord
                    dismiss()
                }
                Button("general.no", role: .cancel) {}
            }
            .searchable(text: $viewModel.searchQuery, prompt: "search.phoneName")
            .crmTitleNav(title: "landlords.choose", titleMode: .inline)
            .task { await viewModel.fetchLandlords() }
        }
        
    }
}

#Preview {
    LandlordsSearchList(selectedLandlordId: .constant(nil))
}
