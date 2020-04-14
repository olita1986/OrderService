import Vapor

struct OrderInput: Content {
    var totalAmount: Int
    var firstname: String
    var lastname: String
    var street: String
    let zip: String
    var city: String
    var items: [OrderItemInput]
}


