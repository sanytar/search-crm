import SwiftUI
import PhotosUI

struct CRMPhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var selectedImages: [Image] = []

    var body: some View {
        PhotosPicker(selection: $selectedItems,
                     matching: .images) {
            Text("Select Multiple Photos")
        }
         .onChange(of: selectedItems) {
             Task {
                 selectedImages = []
                 for item in selectedItems {
                     if let image = try? await item.loadTransferable(type: Image.self) {
                         selectedImages.append(image)
                     }
                 }
             }
         }
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<selectedImages.count, id: \.self) { index in
                    selectedImages[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}
