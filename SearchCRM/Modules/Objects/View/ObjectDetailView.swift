import SwiftUI
let testPhotos = ["1", "2", "3", "4", "5"]

struct ObjectDetailView: View {
    let property: PropertyModel
    
    @State var isFullScreen: Bool = false
    @State var selectedPhoto: String = ""
    
    @State var isLandlordSheetOpen = false
    @State var isTenantSheetOpen = false
    
    @StateObject var landlordViewModel = LandlordViewModel()
    @State var tenantViewModel: TenantsViewModel = TenantsViewModel()
    
    @State var selectedLandlord: LandlordModel? = nil
    @State private var isEditing: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(testPhotos, id: \.self) { photo in
                        Image(photo)
                                .resizable()
                                .scaledToFill()  
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 300)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .overlay(alignment: .topTrailing) {
                        Text(property.isRented ? "objects.isRented" : "objects.available")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(property.isRented ? Color.red.opacity(0.8) : Color.green.opacity(0.8))
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                            .padding(.top, 20)
                            .padding(.trailing, 20)
                    }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("general.title")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack {
                        LabeledContent("objects.type", value: property.type.title)
                        Divider()
                        LabeledContent("objects.address", value: property.address ?? "—")
                        Divider()
                        LabeledContent("objects.price", value: "\(property.price ?? 0) ₽")
                        Divider()
                        LabeledContent("objects.rooms", value: "\(property.rooms ?? 0)")
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("settings.profile.additionalInfo")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack {
                        LabeledContent("comment", value: property.comment ?? "-")
                        Divider()
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                ObjectsLinksView(
                    isLandlordSheetOpen: $isLandlordSheetOpen,
                    isTenantSheetOpen: $isTenantSheetOpen,
                    selectedLandlord: selectedLandlord,
                )
            }
        }
            .sheet(isPresented: $isLandlordSheetOpen) {
                LandlordsSearchList(selectedLandlordId: $selectedLandlord, viewModel: landlordViewModel)
            }
            .sheet(isPresented: $isTenantSheetOpen) {
                Text("Список арендаторов")
            }
            .sheet(isPresented: $isEditing) {
                AddObjectView(viewModel: ObjectsViewModel(property: property))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("settings.profile.edit") {
                        isEditing = true
                    }
                }
            }
    }
}
