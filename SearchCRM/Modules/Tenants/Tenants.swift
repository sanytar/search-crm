import Foundation

struct Tenant {
    let id: UUID
    let name: String
    let phone: String
    let objectName: String
}

extension Tenant {
    static let mockArray: [Tenant] = createMockArray()
    
    static func createMockArray() -> [Tenant] {
        return [
            Tenant(id: UUID(), name: "Aleksandr", phone: "89127221183", objectName: "Квартира в центре"),
            Tenant(id: UUID(), name: "Vladislav", phone: "89128231074", objectName: "Квартира на филеечке")
        ]
    }
}

let mockTenant: [Tenant] = Tenant.mockArray

