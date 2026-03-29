import SwiftUI

struct LandlordCreateView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: LandlordViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("settings.profile.general") {
                    CRMFormField(name: "settings.profile.firstName", text: $viewModel.landlord.firstName)
                    CRMFormField(name: "settings.profile.lastName", text: Binding(
                        get: {viewModel.landlord.lastName ?? ""},
                        set: {viewModel.landlord.lastName = $0}
                    ))
                    CRMFormField(name: "settings.profile.middleName", text: Binding(
                        get: { viewModel.landlord.middleName ?? ""},
                        set: { viewModel.landlord.middleName = $0 }
                    ))
                    CRMFormField(name: "settings.profile.phone", text: $viewModel.landlord.phone)
                    DatePicker("settings.profile.birthDate", selection: Binding(
                        get: {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            return formatter.date(from: viewModel.landlord.birthDate ?? "") ?? Date.now
                        },
                        set: {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            viewModel.landlord.birthDate = formatter.string(from: $0)
                        }
                    ), displayedComponents: .date)
                    
                }
                
                Section("settings.profile.additionalInfo") {
                    CRMFormField(name: "settings.profile.email", text: Binding(
                        get: {   viewModel.landlord.email ?? ""},
                        set: {   viewModel.landlord.email = $0}
                    ))
                }
                
                Section(header: Text("Комментарий")) {
                    TextEditor(text: Binding(
                        get: { viewModel.landlord.comment ?? "" },
                        set: { viewModel.landlord.comment = $0 }
                    ))
                        .frame(height: 100)
                }
            }
            .toolbar() {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.createLandlord()
                            Helpers.doNotificationFeedback(type: .success)
                            dismiss()
                        }
                    } label: {
                        if viewModel.isLoading  {
                            ProgressView()
                        } else {
                            Text("Сохранить")
                        }
                    }
                }
            }
                .crmTitleNav(title: "Новый арендодатель", titleMode: .inline)
                .onAppear {
                    viewModel.landlord = LandlordModel(firstName: "", phone: "")
                }
        }
        
    }
}
