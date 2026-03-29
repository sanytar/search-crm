import SwiftUI

struct CRMItemList: View {
    
    var landlords: [LandlordModel]?
    var isLoading: Bool = false
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
        .overlay {
            if landlords?.isEmpty == true && !isLoading {
                CRMEmptyList(title: "Нет арендодателей", icon: "person.badge.key")
                        
            }
        }
    }
}
