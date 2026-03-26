import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        Form {
                Section {
                    HStack {
                        Spacer()
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 100, height: 100)
                        Spacer()
                    }
                    
                }
                Section(header: Text("Основная информация")) {
                    if !isEditing {
                        LabeledContent("Имя", value: viewModel.profile?.firstName ?? "Не указано")
                        LabeledContent("Фамилия", value: viewModel.profile?.lastName ?? "Не указано")
                        LabeledContent("Отчество", value: viewModel.profile?.middleName ?? "Не указано")
                        LabeledContent("Номер телефона", value: viewModel.profile?.phone ?? "Не указано")
                    } else {
                        TextField("Имя", text: Binding(
                            get: {viewModel.profile?.firstName ?? ""},
                            set: {viewModel.profile?.firstName = $0}
                        ))
                        TextField("Фамилия", text: Binding(
                            get: {viewModel.profile?.lastName ?? ""},
                            set: {viewModel.profile?.lastName = $0}
                        ))
                        TextField("Отчество", text: Binding(
                            get: {viewModel.profile?.middleName ?? ""},
                            set: {viewModel.profile?.middleName = $0}
                        ))
                        TextField("Номер телефона", text: Binding(
                            get: {viewModel.profile?.phone ?? ""},
                            set: {viewModel.profile?.phone = $0}
                        ))
                    }
                    
                }
                
                Section(header: Text("Паспорт"),) {
                    if !isEditing {
                        LabeledContent("Серия", value: viewModel.profile?.firstName ?? "Не указано")
                        LabeledContent("Номер", value: viewModel.profile?.lastName ?? "Не указано")
                        LabeledContent("Кем выдан", value: viewModel.profile?.middleName ?? "Не указано")
                        LabeledContent("Дата выдачи", value: viewModel.profile?.phone ?? "Не указано")
                    } else {
                        TextField("Серия", text: Binding(
                            get: {viewModel.profile?.passportSeries ?? ""},
                            set: {viewModel.profile?.passportSeries = $0}
                        ))
                        TextField("Номер", text: Binding(
                            get: {viewModel.profile?.passportNumber ?? ""},
                            set: {viewModel.profile?.passportNumber = $0}
                        ))
                        TextField("Кем выдан", text: Binding(
                            get: {viewModel.profile?.passportIssuedBy ?? ""},
                            set: {viewModel.profile?.passportIssuedBy = $0}
                        ))
                        TextField("Дата выдачи", text: Binding(
                            get: {viewModel.profile?.passportIssuedDate ?? ""},
                            set: {viewModel.profile?.passportIssuedDate = $0}
                        ))
                    }
                }
                
                Section(header: Text("Дополнительная информация")) {
                    if !isEditing {
                        LabeledContent("Агенство", value: viewModel.profile?.agency ?? "Не указано")
                    } else {
                        TextField("Агенство", text: Binding(
                            get: {viewModel.profile?.agency ?? ""},
                            set: {viewModel.profile?.agency = $0}
                        ))
                    
                    }
                    LabeledContent("Должность", value: viewModel.profile?.role?.name ?? "Не указано")
                }
                
            
            
            
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .task {
            await viewModel.fetchProfile()
        }
        .navigationTitle("settings.profile.title")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "settings.profile.save" : "settings.profile.edit", action: {
                    isEditing.toggle()
                })
            }
        }
    }
}
