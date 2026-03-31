import SwiftUI
import Foundation

struct LandlordsSearchList: View {
    @Binding var selectedLandlordId: UUID?
    @StateObject var viewModel = LandlordViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.landlords ?? [], id: \.id) { item in
                VStack(alignment: .leading) {
                        Text(item.firstName)
                            .font(.headline)
                        Text(item.phone)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
            }
        }
        .task { await viewModel.fetchLandlords() }
    }
}
