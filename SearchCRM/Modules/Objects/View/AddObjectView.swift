import SwiftUI

struct AddObjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основное") {
                    Picker("Тип", selection: $viewModel.object.type) {
                        ForEach(ObjectType.allCases, id: \.self) { item in
                            Text(item.title).tag(item)
                        }
                        
                    }
                    CRMFormField(name: "Цена", keyBoardType: .numberPad, text: Binding(
                        get: {String(viewModel.object.price)},
                        set: {viewModel.object.price = Int($0) ?? 0}
                        
                    ))
                    
                    CRMFormField(name: "Кол-во комнат", keyBoardType: .numberPad, text: Binding(
                        get: {String(viewModel.object.rooms)},
                        set: {viewModel.object.rooms = Int($0) ?? 0}
                        
                    ))
                    
                    CRMFormField(name: "Адрес", text: Binding(
                        get: {viewModel.object.address},
                        set: {viewModel.object.address = $0}
                        
                    ))
                    
                    CRMFormField(name: "Площадь",keyBoardType: .numberPad, text: Binding(
                        get: {String(viewModel.object.area ?? 0)},
                        set: {viewModel.object.area = Int($0) ?? 0}
                    ))
                }
                
                Section("Арендодатель") {
                    Text("Тут будет выбор арендодателя")
                }
                
                Section("Фотографии") {
                    CRMPhotoPicker()
                }
                
                Section("Комментарий") {
                    TextEditor(text: Binding(
                        get: { viewModel.object.comment ?? "" },
                        set: { viewModel.object.comment = $0 }
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
                            await viewModel.createObject()
                            dismiss()
                        }
                    } label: {
                        Text("Сохранить")
                    }
                }
            }
            
            .crmTitleNav(title: "Новый объект", titleMode: .inline)
        }
    }
}

#Preview {
    AddObjectView()
}
