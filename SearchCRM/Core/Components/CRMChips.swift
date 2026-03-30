import SwiftUI

struct CCRMChips: View {
    @Binding var selectedChip: ObjectChips
    
    func isSelected(_ chip: ObjectChips) -> Bool {
        selectedChip == chip
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(ObjectChips.allCases, id: \.self) { chip in
                    Button(action: { selectedChip = chip }) {
                        Text(chip.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(isSelected(chip) ? Color.blue : Color.gray.opacity(0.15))
                                .foregroundStyle(isSelected(chip) ? .white : .primary)
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
            }
        }.textCase(nil)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
        
    }
}
