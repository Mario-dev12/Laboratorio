import express from 'express'
const boxRouter = express.Router()
import boxController from './box.controller.js'


boxRouter.get('/ingreso', boxController.readIncome)
boxRouter.get('/egreso', boxController.readBills)
boxRouter.get('/deuda', boxController.readDebt)
boxRouter.post('/', boxController.createDebt)
boxRouter.delete('/:id', boxController.deleteDebt)
boxRouter.delete('/exam/:id', boxController.deleteDebtExam)


export default boxRouter