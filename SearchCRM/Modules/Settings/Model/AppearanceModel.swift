import SwiftUI

enum AppColor: String, CaseIterable {
    case light
    case dark
    case system
    
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .light:
            return "settings.appearance.light"
        case .dark:
            return "settings.appearance.dark"
        case .system:
            return "settings.appearance.system"
        }
    }
}
