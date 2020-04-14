import Vapor
import Fluent

final class OrderController {
    func list(_ request: Request) throws -> EventLoopFuture<[OrderResponse]> {
        return Order.query(on: request.db)
            .all()
            .map { orders in
                return orders.map {
                    OrderResponse(order: $0, items: $0.items)
                }
            }
    }

    func listMine(_ request: Request) throws -> EventLoopFuture<[OrderResponse]> {
        return Order.query(on: request.db)
        .all()
        .map { orders in
            return orders.map {
                OrderResponse(order: $0, items: $0.items)
            }
        }
    }

    func postPayment(_ request: Request) throws -> EventLoopFuture<AddedPaymentResponse> {
        let paymentInput = try request.content.decode(PaymentInput.self)

        return Order.query(on: request.db)
            .filter(\Order.$id == paymentInput.orderId).all()
            .flatMap { orders in
                if orders.count == 0 {
                    return request.eventLoop.makeFailedFuture(OrderError.orderNotFound)
                }

                let payment = OrderPayment(totalAmount: paymentInput.totalAmount, method: paymentInput.method, order: orders.first!)

                return payment.save(on: request.db).transform(to: AddedPaymentResponse())
            }
    }

    func post(_ request: Request) throws -> EventLoopFuture<OrderResponse> {
        let orderInput = try request.content.decode(OrderInput.self)

        let order = Order(
            totalAmount: orderInput.totalAmount,
            firstname: orderInput.firstname,
            lastname: orderInput.lastname,
            street: orderInput.street,
            zip: orderInput.zip,
            city: orderInput.city
        )

        return order.save(on: request.db).flatMap { _ in
            var saving: [EventLoopFuture<Void>] = []

            var items: [OrderItem] = []

            for inputItem in orderInput.items {
                let item = OrderItem(
                    totalAmount: inputItem.unitPrice * inputItem.quantity,
                    unitPrice: inputItem.unitPrice,
                    quantity: inputItem.quantity,
                    order: order
                )
                saving.append(item.save(on: request.db).map {
                    items.append(item)
                })
            }

            return saving.flatten(on: request.eventLoop).map {
                return OrderResponse(order: order, items: items)
            }
        }
    }
}
