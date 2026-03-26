import SwiftUI

struct CRMFormField: View {
    let name: String.LocalizationValue
    var keyBoardType: UIKeyboardType = .default
    
    @Binding var text: String
    
    var body: some View {
        LabeledContent(String(localized: name)) {
            TextField(String(localized: name), text: Binding(
                get: { text },
                set: { text = $0 }
            ))
            .multilineTextAlignment(.trailing)
        }.keyboardType(keyBoardType)
    }
}
