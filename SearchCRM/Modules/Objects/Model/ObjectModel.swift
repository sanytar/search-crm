import Foundation

enum ObjectType: String, Codable, CaseIterable {
    case apartment
    case house
    
    var title: String {
        switch self {
            case .apartment: return "Квартира"
            case .house: return "Дом"
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
    var isRented: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
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
            case .all: return "Все"
            case .isNotRented: return "Свободные"
            case .isNotLandlord: return "Нет собственника"
        }
    }
}
