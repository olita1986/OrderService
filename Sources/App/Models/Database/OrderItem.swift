import Vapor
import Fluent

final class OrderItem: Model {
    static let schema: String = "orderItems"

    @ID(custom: "id")
    var id: Int?

    @Field(key: "unitPrice")
    var unitPrice: Int

    @Field(key: "totalAmount")
    var totalAmount: Int

    @Field(key: "productId")
    var productId: Int

    @Field(key: "quantity")
    var quantity: Int

    @Parent(key: "orderId")
    var order: Order

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
        unitPrice: Int,
        quantity: Int,
        order: Order
    ) {
        self.id = id
        self.totalAmount = totalAmount
        self.unitPrice = unitPrice
        self.quantity = quantity
        self.order = order
    }
}
