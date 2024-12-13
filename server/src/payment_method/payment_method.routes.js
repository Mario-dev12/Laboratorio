import express from 'express'
const payment_methodRouter = express.Router()
import payment_methodController from './payment_method.controller.js'


payment_methodRouter.get('/', payment_methodController.readPayment_methods)
payment_methodRouter.get('/name', payment_methodController.readPayment_methodByName)
payment_methodRouter.post('/', payment_methodController.createPayment_method)
payment_methodRouter.put('/:id', payment_methodController.updatePayment_method)
payment_methodRouter.delete('/:id', payment_methodController.deletePayment_method)


export default payment_methodRouter