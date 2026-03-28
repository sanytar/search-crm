import SwiftUI

struct CRMListHeader: ViewModifier {
    @Binding var searchText: String
    
    let title: LocalizedStringKey
    let searchPlaceholder: String
    
    var onAdd: () -> Void
    var onFilter: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .searchable(text: $searchText, prompt: searchPlaceholder)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: onFilter) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                    }
                }
            }
            
            
    }
}

extension View {
    func crmListHeader(searchText: Binding<String>, title: LocalizedStringKey, searchPlaceholder: String, onAdd: @escaping () -> Void, onFilter: @escaping () -> Void) -> some View {
        modifier(CRMListHeader(searchText: searchText, title: title, searchPlaceholder: searchPlaceholder, onAdd: onAdd, onFilter: onFilter))
    }
}
// 1. Title
// 2. Search
// 3. toolbar with 2 items ( filter, add entity )
