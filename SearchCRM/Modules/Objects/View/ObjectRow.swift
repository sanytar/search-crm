import SwiftUI

struct ObjectRow: View {
    let object: PropertyModel
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(object.type.title) • \(object.rooms ?? 0) \(String(localized: "objects.rooms.short"))")
                    .font(.headline)
                
                Spacer()
                
                Text("\(object.price ?? 0) \(String(localized: "objects.price.type"))")
                    .font(.headline)
                    .foregroundStyle(.blue)
            }

            HStack {
                Text(object.address ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("\(object.area ?? 0) м²")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text(object.isRented ? "objects.isRented" : "objects.available")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(object.isRented ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                .foregroundStyle(object.isRented ? .red : .green)
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .padding(.vertical, 6)
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Удалить", systemImage: "trash")
            }
        }
    }
}
