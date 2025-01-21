import express from 'express'
const paymentRouter = express.Router()
import paymentController from './payment.controller.js'


paymentRouter.get('/', paymentController.readPayments)
paymentRouter.post('/', paymentController.createPayment)
paymentRouter.put('/:id', paymentController.updatePayment)
paymentRouter.delete('/:id', paymentController.deletePayment)


export default paymentRouter