import SwiftUI

struct CRMInput: View {
    let title: String
    let placeholder: String
    
    @Binding var text: String
    
    var isSecure: Bool = false
    var type: UIKeyboardType = .default
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            Group {
                if isSecure {
                        SecureField(placeholder, text: $text)
                        .crmInputStyle()
                    } else {
                        TextField(placeholder, text: $text)
                            .crmInputStyle()
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .keyboardType(type)
                    }
            }
            
            
        }
        
    }
}
