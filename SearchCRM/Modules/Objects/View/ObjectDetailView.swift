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
    
    @State var selectedLandlordId: UUID? = nil
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
                        Text(property.isRented ? "Сдана" : "Свободна")
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
                    Text("Основное")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack {
//                        LabeledContent("Тип", value: property.type.title)
//                        Divider()
                        LabeledContent("Адрес", value: property.address ?? "—")
                        Divider()
                        LabeledContent("Цена", value: "\(property.price ?? 0) ₽")
                        Divider()
                        LabeledContent("Комнаты", value: "\(property.rooms ?? 0)")
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Дополнительная информация")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack {
                        LabeledContent("Комментарий", value: property.comment ?? "-")
                        Divider()
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                VStack {
                    Button {
                        isLandlordSheetOpen = true
                    } label: {
                        HStack {
                            Text("Арендодатель")
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("Не указан")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                    }
                    Divider()
                    Button {
                        isTenantSheetOpen = true
                    } label: {
                        HStack {
                            Text("Арендатор")
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("Не указан")
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
            .sheet(isPresented: $isLandlordSheetOpen) {
                LandlordsSearchList(selectedLandlordId: $selectedLandlordId, viewModel: landlordViewModel)
            }
            .sheet(isPresented: $isTenantSheetOpen) {
                Text("Список арендаторов")
            }
    }
}
