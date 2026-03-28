import Foundation

enum ObjectType: String, Codable {
    case apartment
    case house
}

struct PropertyModel: Codable, Identifiable {
    var id: UUID?
    var type: ObjectType
    var price: Int
    var rooms: Int
    var address: String
    var landlordId: UUID?
    var comment: String?
    var area: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case rooms
        case type
        case address
        case landlordId = "landlord_id"
        case comment
        case area
    }
}


//type — Тип объекта
//rooms — Количество комнат
//area — Площадь
//price — Стоимость
//address — Адрес
//landlord_id — Привязка к арендодателю
//comment — Комментарий
