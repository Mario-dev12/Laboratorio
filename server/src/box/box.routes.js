import express from 'express'
const boxRouter = express.Router()
import boxController from './box.controller.js'


boxRouter.get('/ingreso', boxController.readIncome)
boxRouter.get('/egreso', boxController.readBills)


export default boxRouter