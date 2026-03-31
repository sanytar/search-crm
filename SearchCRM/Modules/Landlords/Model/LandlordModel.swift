import Foundation

struct LandlordModel: Codable, Identifiable  {
    var id: UUID?
    var firstName: String
    var lastName: String?
    var middleName: String?
    var comment: String?

    var birthDate: String?
    var phone: String
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case birthDate = "birth_date"
        case phone
        case email
        case comment
    }
}

struct NewLandlordModel: Codable  {
    var firstName: String
    var lastName: String?
    var middleName: String?
    var comment: String?

    var birthDate: String?
    var phone: String
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case birthDate = "birth_date"
        case phone
        case email
        case comment
    }
}

enum LandlordSort: String, SortOption {
    case byName = "По имени"
    case byDate = "По дате"
    
    var title: String { rawValue }
}
