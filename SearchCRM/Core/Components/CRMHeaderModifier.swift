import SwiftUI

struct CRMListHeader: ViewModifier {
    @Binding var searchText: String
    
    let title: LocalizedStringKey
    let searchPlaceholder: String
    
    var onAdd: () -> Void
    var onFilter: () -> Void
    
    @Binding var sortOption: SortMenuList
    
    func body(content: Content) -> some View {
        content
            .searchable(text: $searchText)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Сортировка", selection: $sortOption) {
                            ForEach(SortMenuList.allCases, id: \.self) { item in
                                Text(item.rawValue).tag(item)
                            }
                        }
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
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
    func crmListHeader(
        searchText: Binding<String>,
           title: LocalizedStringKey,
           searchPlaceholder: String,
           onAdd: @escaping () -> Void,
           onFilter: @escaping () -> Void,
    sortOption: Binding<SortMenuList>) -> some View {
        modifier(CRMListHeader(searchText: searchText, title: title, searchPlaceholder: searchPlaceholder, onAdd: onAdd, onFilter: onFilter, sortOption: sortOption))
    }
}
