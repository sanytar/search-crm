import Foundation

struct ProfileModel: Codable {
    let id: UUID
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var gender: String?
    var birthDate: String?
    var passportIssuedDate: String?
    var passportSeries: String?
    var passportNumber: String?
    var passportIssuedBy: String?
    var registrationAddress: String?
    var livingAddress: String?
    var phone: String?
    var agency: String?
    var role: Role?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case gender
        case birthDate = "birth_date"
        case passportIssuedDate = "passport_issued_date"
        case passportSeries = "passport_series"
        case passportNumber = "passport_number"
        case passportIssuedBy = "passport_issued_by"
        case registrationAddress = "registration_address"
        case livingAddress = "living_address"
        case phone
        case agency
        case role = "roles"
    }
}

struct Role : Codable {
    let id: Int
    let name: String
}
