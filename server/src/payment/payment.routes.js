import express from 'express'
const paymentRouter = express.Router()
import paymentController from './payment.controller.js'


paymentRouter.get('/', paymentController.readPayments)
paymentRouter.get('/pay/:idexam/:idpayment_method', paymentController.readPaymentByExamIdAndPaymentMethodid)
paymentRouter.get('/exam/:id', paymentController.readPaymentByExamId)
paymentRouter.post('/', paymentController.createPayment)
paymentRouter.put('/:id', paymentController.updatePayment)
paymentRouter.delete('/:id', paymentController.deletePayment)


export default paymentRouter