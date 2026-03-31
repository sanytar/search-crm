import SwiftUI

struct AddObjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    @EnvironmentObject var toast: ToastManager
    
    var body: some View {
        NavigationStack {
            Form {
                Section("settings.profile.general") {
                    Picker("objects.type", selection: $viewModel.object.type) {
                        ForEach(ObjectType.allCases, id: \.self) { item in
                            Text(item.title).tag(item)
                        }
                        
                    }
                    CRMFormField(name: "objects.price", keyBoardType: .numberPad, text: Binding(
                        get: { viewModel.object.price != nil ? String(viewModel.object.price!) : "" },
                        set: { viewModel.object.price = Int($0) }
                    ))
                    
                    CRMFormField(name: "objects.rooms", keyBoardType: .numberPad, text: Binding(
                        get: { viewModel.object.rooms != nil ? String(viewModel.object.rooms!) : "" },
                        set: { viewModel.object.rooms = Int($0) }
                    ))
                    
                    CRMFormField(name: "objects.address", text: Binding(
                        get: { viewModel.object.address ?? "" },
                        set: { viewModel.object.address = $0.isEmpty ? nil : $0 }
                    ))
                    
                    CRMFormField(name: "objects.area", keyBoardType: .numberPad, text: Binding(
                        get: { viewModel.object.area.map(String.init) ?? "" },
                        set: { viewModel.object.area = Int($0) }
                    ))
                }
                
                Section("landlord.title") {
                    Text("Тут будет выбор арендодателя")
                }
                
                Section("general.photos") {
                    CRMPhotoPicker()
                }
                
                Section("comment") {
                    TextEditor(text: Binding(
                        get: { viewModel.object.comment ?? "" },
                        set: { viewModel.object.comment = $0.isEmpty ? nil : $0 }
                    ))
                        .frame(height: 100)
                }
            }
            
            .toolbar() {
                ToolbarItem(placement: .topBarLeading) {
                    Button("settings.logout.cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            if await viewModel.createObject() {
                                Helpers.doNotificationFeedback(type: .success)
                                dismiss()
                                toast.show("objects.create.success", type: .success)
                            }
                            
                        }
                    } label: {
                        Text("settings.profile.save")
                    }
                }
            }
            
            .crmTitleNav(title: "objects.new", titleMode: .inline)
        }
    }
}
//
//#Preview {
//    AddObjectView()
//}
