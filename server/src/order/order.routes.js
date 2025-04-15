import express from 'express'
const orderRouter = express.Router()
import orderController from './order.controller.js'


orderRouter.get('/', orderController.readOrders)
orderRouter.get('/order/:idexam/:idprofile', orderController.readOrderByExamIdAndProfileId)
orderRouter.get('/exam/:id', orderController.readOrderByExamId)
orderRouter.get('/orders', orderController.readOrdersDay)
orderRouter.get('/cultiveorders', orderController.readCultiveOrdersDay)
orderRouter.get('/spermiogramorders', orderController.readSpermiogramOrdersDay)
orderRouter.get('/history', orderController.readHistOrdersDay)
orderRouter.get('/cultivehistory', orderController.readCultiveHistOrdersDay)
orderRouter.get('/spermiogramhistory', orderController.readSpermiogramHistOrdersDay)
orderRouter.post('/', orderController.createOrder)
orderRouter.put('/:id', orderController.updateOrder)
orderRouter.put('/status/:id', orderController.updateStatusOrder)
orderRouter.delete('/:id', orderController.deleteOrder)
orderRouter.delete('/order/:idexam/:idprofile', orderController.deleteOrderByExamIdAndProfileId)


export default orderRouter