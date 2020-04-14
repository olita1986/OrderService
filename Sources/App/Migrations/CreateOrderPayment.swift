import Fluent

struct CreateOrderPayment: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orderPayments")
            .field("id", .int, .identifier(auto: true))
            .field("totalAmount", .int, .required)
            .field("method", .string, .required)
            .field("orderId", .int, .required)
            .field("createdAt", .date)
            .field("updatedAt", .date)
            .field("deletedAt", .date)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orderPayments").delete()
    }
}
