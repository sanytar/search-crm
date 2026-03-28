import SwiftUI

struct CRMItemList: View {
    
    var landlords: [LandlordModel]?
    var body: some View {
        List {
            ForEach(landlords ?? []) { item in
                VStack(alignment: .leading) {
                        Text(item.firstName)
                            .font(.headline)
                        Text(item.phone)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
            }
        }
    }
}
