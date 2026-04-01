import SwiftUI

struct ObjectsLinksView: View {
    @Binding var isLandlordSheetOpen: Bool
    @Binding var isTenantSheetOpen: Bool
    
    let selectedLandlord: LandlordModel?
    
    var body: some View {
        VStack {
            Button {
                isLandlordSheetOpen = true
            } label: {
                if selectedLandlord != nil {
                    Text("landlord.title")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(selectedLandlord?.firstName ?? "settings.profile.notSpecified")
                } else {
                    HStack {
                        Text("landlord.title")
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("settings.profile.notSpecified")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                }
                
            }
            Divider()
            Button {
                isTenantSheetOpen = true
            } label: {
                HStack {
                    Text("tenant.title")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("settings.profile.notSpecified")
                        .foregroundStyle(.secondary)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}
