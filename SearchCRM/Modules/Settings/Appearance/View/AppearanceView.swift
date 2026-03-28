import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            Picker("settings.appearance.theme", selection: $appState.theme) {
                ForEach(AppColor.allCases, id: \.self) {  item in
                    Text(item.title).tag(item)
                }
            }.pickerStyle(.inline)
            
        }
    }
}
