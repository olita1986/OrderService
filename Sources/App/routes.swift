import Fluent
import Vapor
import SimpleJWTMiddleware

func routes(_ app: Application) throws {
    let currentVersion = app.grouped(.anything, "orders")
    currentVersion.get("health") { req in
        return "Healthy!"
    }

    let protected = currentVersion.grouped(SimpleJWTMiddleware())

    let orderController = OrderController()
    protected.post("", use: orderController.post)
    protected.get("", use: orderController.listMine)
    protected.get("all", use: orderController.list)
    protected.post("payment", use: orderController.postPayment)
}
