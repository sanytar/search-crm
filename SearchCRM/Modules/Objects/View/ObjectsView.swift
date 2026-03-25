import SwiftUI

struct ObjectsView: View {
    @State private var searchText = ""
    @State private var isShowingFilter = false
    @State private var isShowingAddModal = false
    
    var body: some View {
        NavigationStack {
            List {
                // Тут скоро будут наши оранжевые карточки
                ForEach(0..<5) { _ in
                    Text("Объект недвижимости")
                }
            }
            .navigationTitle("Объекты")
            
            // 1. ПОИСК: Появляется под заголовком при свайпе вниз
            .searchable(text: $searchText, prompt: "Поиск по названию")
            
            // 2. ТУЛБАР: Кнопки управления
            .toolbar {
                // Кнопка фильтра слева
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowingFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                
                // Кнопка «Плюс» справа
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddModal.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            // Вызов модалки фильтров
            .sheet(isPresented: $isShowingFilter) {
                Text("Фильтры")
                    .presentationDetents([.medium]) // Модалка на пол-экрана
            }
            // Вызов модалки добавления (про которую ты спрашивал)
            .sheet(isPresented: $isShowingAddModal) {
                AddObjectView() // Создадим этот файл следующим шагом
            }
        }
        
    }
}
