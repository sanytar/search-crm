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
                Section(header: Text("settings.profile.general")) {
                    if !isEditing {
                        LabeledContent("settings.profile.firstName", value: viewModel.profile?.firstName ?? "Не указано")
                        LabeledContent("settings.profile.lastName", value: viewModel.profile?.lastName ?? "Не указано")
                        LabeledContent("settings.profile.middleName", value: viewModel.profile?.middleName ?? "Не указано")
                        LabeledContent("settings.profile.phone", value: viewModel.profile?.phone ?? "Не указано")
                    } else {
                        TextField("settings.profile.firstName", text: Binding(
                            get: {viewModel.profile?.firstName ?? ""},
                            set: {viewModel.profile?.firstName = $0}
                        ))
                        TextField("settings.profile.lastName", text: Binding(
                            get: {viewModel.profile?.lastName ?? ""},
                            set: {viewModel.profile?.lastName = $0}
                        ))
                        TextField("settings.profile.middleName", text: Binding(
                            get: {viewModel.profile?.middleName ?? ""},
                            set: {viewModel.profile?.middleName = $0}
                        ))
                        TextField("settings.profile.phone", text: Binding(
                            get: {viewModel.profile?.phone ?? ""},
                            set: {viewModel.profile?.phone = $0}
                        ))
                    }
                    
                }
                
                Section(header: Text("settings.profile.passport"),) {
                    if !isEditing {
                        LabeledContent("settings.profile.passportSeries", value: viewModel.profile?.firstName ?? "Не указано")
                        LabeledContent("settings.profile.passportNumber", value: viewModel.profile?.lastName ?? "Не указано")
                        LabeledContent("settings.profile.passportIssuedBy", value: viewModel.profile?.middleName ?? "Не указано")
                        LabeledContent("settings.profile.passportIssuedDate", value: viewModel.profile?.phone ?? "Не указано")
                    } else {
                        TextField("settings.profile.passportSeries", text: Binding(
                            get: {viewModel.profile?.passportSeries ?? ""},
                            set: {viewModel.profile?.passportSeries = $0}
                        ))
                        TextField("settings.profile.passportNumber", text: Binding(
                            get: {viewModel.profile?.passportNumber ?? ""},
                            set: {viewModel.profile?.passportNumber = $0}
                        ))
                        TextField("settings.profile.passportIssuedBy", text: Binding(
                            get: {viewModel.profile?.passportIssuedBy ?? ""},
                            set: {viewModel.profile?.passportIssuedBy = $0}
                        ))
                        TextField("settings.profile.passportIssuedDate", text: Binding(
                            get: {viewModel.profile?.passportIssuedDate ?? ""},
                            set: {viewModel.profile?.passportIssuedDate = $0}
                        ))
                    }
                }
                
                Section(header: Text("settings.profile.additionalInfo")) {
                    if !isEditing {
                        LabeledContent("settings.profile.agency", value: viewModel.profile?.agency ?? "Не указано")
                    } else {
                        TextField("settings.profile.agency", text: Binding(
                            get: {viewModel.profile?.agency ?? ""},
                            set: {viewModel.profile?.agency = $0}
                        ))
                    
                    }
                    LabeledContent("settings.profile.role", value: viewModel.profile?.role?.name ?? "Не указано")
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
