import express from 'express'
const orderRouter = express.Router()
import orderController from './order.controller.js'


orderRouter.get('/', orderController.readOrders)
orderRouter.get('/orders', orderController.readOrdersDay)
orderRouter.get('/history', orderController.readHistOrdersDay)
orderRouter.post('/', orderController.createOrder)
orderRouter.put('/:id', orderController.updateOrder)
orderRouter.delete('/:id', orderController.deleteOrder)


export default orderRouter