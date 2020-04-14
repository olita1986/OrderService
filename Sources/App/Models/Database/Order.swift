import Vapor
import Fluent

final class Order: Model {
    static let schema: String = "orders"

    @ID(custom: "id")
    var id: Int?

    @Field(key: "totalAmount")
    var totalAmount: Int

    @Field(key: "paidAmount")
    var paidAmount: Int

    @Field(key: "userId")
    var userId: Int

    @Field(key: "status")
    var status: Int

    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?

    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?

    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?

    @Field(key: "firstname")
    var firstname: String

    @Field(key: "lastname")
    var lastname: String

    @Field(key: "street")
    var street: String

    @Field(key: "zip")
    var zip: String

    @Field(key: "city")
    var city: String

    @Children(for: \OrderItem.$order)
    var items: [OrderItem]

    init() {}

    init(
        id: Int? = nil,
        totalAmount: Int,
        paidAmount: Int = 0,
        status: Int = 0,
        firstname: String,
        lastname: String,
        street: String,
        zip: String,
        city: String
    ) {
        self.id = id
        self.totalAmount = totalAmount
        self.paidAmount = paidAmount
        self.status = status
        self.firstname = firstname
        self.lastname = lastname
        self.street = street
        self.zip = zip
        self.city = city
    }
}
