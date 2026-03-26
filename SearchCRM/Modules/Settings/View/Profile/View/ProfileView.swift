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
                        LabeledContent("settings.profile.firstName", value: viewModel.profile?.firstName ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.lastName", value: viewModel.profile?.lastName ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.middleName", value: viewModel.profile?.middleName ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.phone", value: viewModel.profile?.phone ?? String(localized: "settings.profile.notSpecified"))
                    } else {
                        LabeledContent(String(localized: "settings.profile.firstName")) {
                            TextField("settings.profile.firstName", text: Binding(
                                get: { viewModel.editingProfile?.firstName ?? "" },
                                set: { viewModel.editingProfile?.firstName = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }
                        LabeledContent(String(localized: "settings.profile.lastName")) {
                            TextField("settings.profile.lastName", text: Binding(
                                get: { viewModel.editingProfile?.lastName ?? "" },
                                set: { viewModel.editingProfile?.lastName = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }
                        LabeledContent(String(localized: "settings.profile.middleName")) {
                            TextField("settings.profile.middleName", text: Binding(
                                get: { viewModel.editingProfile?.middleName ?? "" },
                                set: { viewModel.editingProfile?.middleName = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }
                        LabeledContent(String(localized: "settings.profile.phone")) {
                            TextField("settings.profile.phone", text: Binding(
                                get: { viewModel.editingProfile?.phone ?? "" },
                                set: { viewModel.editingProfile?.phone = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }
                    }
                    
                }
                
                Section(header: Text("settings.profile.passport"),) {
                    if !isEditing {
                        LabeledContent("settings.profile.passportSeries", value: viewModel.profile?.passportSeries ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.passportNumber", value: viewModel.profile?.passportNumber ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.passportIssuedBy", value: viewModel.profile?.passportIssuedBy ?? String(localized: "settings.profile.notSpecified"))
                        LabeledContent("settings.profile.passportIssuedDate", value: viewModel.profile?.passportIssuedDate ?? String(localized: "settings.profile.notSpecified"))
                    } else {
                        LabeledContent(String(localized: "settings.profile.passportSeries")) {
                            TextField("settings.profile.passportSeries", text: Binding(
                                get: { viewModel.editingProfile?.passportSeries ?? "" },
                                set: { viewModel.editingProfile?.passportSeries = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }.keyboardType(.numberPad)
                        // TODO: доделать по сеньорски, через keyPath
                        CRMFormField(
                            name: "settings.profile.passportNumber",
                            text: Binding(
                                get: { viewModel.editingProfile?.passportNumber ?? "" }, // String? → String
                                set: { viewModel.editingProfile?.passportNumber = $0 }
                            )
                        )
                        
                        LabeledContent(String(localized: "settings.profile.passportIssuedBy")) {
                            TextField("settings.profile.passportIssuedBy", text: Binding(
                                get: { viewModel.editingProfile?.passportIssuedBy ?? "" },
                                set: { viewModel.editingProfile?.passportIssuedBy = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }.keyboardType(.numberPad)
                        
                        LabeledContent(String(localized: "settings.profile.passportIssuedDate")) {
                            TextField("settings.profile.passportIssuedDate", text: Binding(
                                get: { viewModel.editingProfile?.passportIssuedDate ?? "" },
                                set: { viewModel.editingProfile?.passportIssuedDate = $0 }
                            ))
                            .multilineTextAlignment(.trailing)
                        }.keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("settings.profile.additionalInfo")) {
                    if !isEditing {
                        LabeledContent("settings.profile.agency", value: viewModel.profile?.agency ?? String(localized: "settings.profile.notSpecified"))
                    } else {
                        TextField("settings.profile.agency", text: Binding(
                            get: {viewModel.editingProfile?.agency ?? ""},
                            set: {viewModel.editingProfile?.agency = $0}
                        ))
                    
                    }
                    LabeledContent("settings.profile.role", value: viewModel.profile?.role?.localizedName ?? String(localized: "settings.profile.notSpecified"))
                }
                
            
            
            
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .task {
            await viewModel.fetchProfile()
        }
        .navigationTitle("settings.profile.title")
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewModel.cancelEditing()
                        isEditing = false
                    }) {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "settings.profile.save" : "settings.profile.edit", action: {
                    if isEditing {
                        Task { await viewModel.saveProfile() }
                    } else {
                        viewModel.startEditing()
                    }
                    isEditing.toggle()
                })
            }
        }
    }
}
