import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case objects
    case tenants
    case landlords
    case settings
    
    var id: String { self.rawValue }
    
    var title: LocalizedStringKey {
        switch self {
        case .objects: return "objects.title"
        case .tenants: return "tenants.title"
        case .landlords: return "landlords.title"
        case .settings: return "settings.title"
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
