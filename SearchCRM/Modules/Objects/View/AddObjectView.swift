import SwiftUI

struct AddObjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var objectName = ""
    @State private var address = ""
    @State private var radius = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Основная информация")) {
                    TextField("Название объекта", text: $objectName)
                    TextField("Адрес", text: $address)
                }
                
                Section(header: Text("Параметры")) {
                    HStack {
                        Text("Площадь")
                        Spacer()
                        TextField("например, 15", text: $radius)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Комментарий")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
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
                    .disabled(objectName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddObjectView()
}
