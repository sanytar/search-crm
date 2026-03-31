import Foundation

struct TenantsModel: Codable, Identifiable {
    let id: UUID
    let fullName: String
    let phone: String
    let email: String
    let comment: String
    let agentId: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case phone
        case email
        case comment
        case agentId = "agent_id"
        
    }
}

struct NewTenantModel: Codable {
    var fullName: String
    var phone: String
    var email: String?
    var comment: String?
    var agentId: UUID?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case phone
        case email
        case comment
        case agentId = "agent_id"
        
    }
}

enum SortTenants: String, SortOption {
    case byName = "По имени"
    case byDate = "По дате"
    
    var title: String { rawValue }
}
