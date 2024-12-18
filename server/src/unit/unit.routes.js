import express from 'express'
const unitRouter = express.Router()
import unitController from './unit.controller.js'


unitRouter.get('/', unitController.readUnits)
unitRouter.get('/name', unitController.readUnitByName)
unitRouter.post('/', unitController.createUnit)
unitRouter.put('/:id', unitController.updateUnit)
unitRouter.delete('/:id', unitController.deleteUnit)


export default unitRouter