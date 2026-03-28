import SwiftUI

struct AddObjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ObjectsViewModel = ObjectsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основное") {
//                    CRMFormField(name: "Тип объекта")
                }
                
                Section("Дополнительная информация") {
                    
                }
            }
            .navigationTitle("Новый объект")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddObjectView()
}
