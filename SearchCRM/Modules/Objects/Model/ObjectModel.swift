import Foundation
import SwiftUI

enum ObjectType: String, Codable, CaseIterable {
    case apartment
    case house
    
    var title: String {
        switch self {
        case .apartment: return String(localized: "objects.apartment")
        case .house: return String(localized: "objects.house")
        }
    }
}

struct PropertyModel: Codable, Identifiable {
    var id: UUID
    var type: ObjectType
    var price: Int?
    var rooms: Int?
    var address: String?
    var landlordId: UUID?
    var comment: String?
    var area: Int?
    var photos: [String]?
    var isRented: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case rooms
        case photos
        case type
        case address
        case landlordId = "landlord_id"
        case comment
        case area
        case isRented = "is_rented"
    }
}

struct newPropertyModel: Codable {
    var type: ObjectType
    var price: Int?
    var rooms: Int?
    var address: String?
    var landlordId: UUID?
    var comment: String?
    var area: Int?
    var isRented: Bool
    
    enum CodingKeys: String, CodingKey {
        case price
        case rooms
        case type
        case address
        case landlordId = "landlord_id"
        case comment
        case area
        case isRented = "is_rented"
    }
}

enum ObjectChips: String, CaseIterable, Codable {
    case all
    case isNotRented
    case isNotLandlord
    
    var title: String {
        switch self {
            case .all: return String(localized: "objects.chips.all")
            case .isNotRented: return String(localized: "objects.chips.available")
            case .isNotLandlord: return String(localized: "objects.chips.isNotLandlord")
        }
    }
}

enum SortObjects: String, CaseIterable, SortOption {
    case priceDesc
    case priceAsc
    case areaDesc
    case areaAsc
    case freeFirst
    
    var title: String {
        switch self {
        case .priceDesc: return String(localized: "objects.sort.priceDesc")
        case .priceAsc: return String(localized: "objects.sort.priceAsc")
        case .areaDesc: return String(localized: "objects.sort.areaDesc")
        case .areaAsc: return String(localized: "objects.sort.areaAsc")
        case .freeFirst: return String(localized: "objects.sort.freeFirst")
        }
        
    }
}
