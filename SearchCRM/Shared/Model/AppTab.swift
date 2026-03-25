import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case objects
    case tenants
    case landlords
    case settings
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .objects: return "Объекты"
        case .tenants: return "Арендаторы"
        case .landlords: return "Арендодатели"
        case .settings: return "Настройки"
        }
    }
    
    var icon: String {
        switch self {
        case .objects: return "house.fill"
        case .tenants: return "person.crop.badge.magnifyingglass.fill"
        case .landlords: return "person.badge.key.fill"
        case .settings: return "gearshape"
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .objects: ObjectsView()
        case .tenants: TenantsView()
        case .landlords: LandlordsView()
        case .settings: SettingsView()
        }
    }
}
