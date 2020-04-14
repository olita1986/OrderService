import Fluent

struct CreateOrderItem: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orderItems")
            .field("id", .int, .identifier(auto: true))
            .field("totalAmount", .int, .required)
            .field("unitPrice", .int, .required)
            .field("productId", .int, .required)
            .field("quantity", .int, .required)
            .field("orderId", .int, .required)
            .field("createdAt", .date)
            .field("updatedAt", .date)
            .field("deletedAt", .date)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orderItems").delete()
    }
}
