import Vapor
import Fluent

final class OrderPayment: Model {
    static let schema: String = "orderPayments"

    @ID(custom: "id")
    var id: Int?

    @Field(key: "totalAmount")
    var totalAmount: Int

    @Parent(key: "orderId")
    var order: Order

    @Field(key: "method")
    var method: String

    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?

    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?

    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?

    init() {}

    init(
        id: Int? = nil,
        totalAmount: Int,
        method: String,
        order: Order
    ){
        self.id = id
        self.totalAmount = totalAmount
        self.method = method
        self.order = order
    }
}
