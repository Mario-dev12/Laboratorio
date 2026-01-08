import express from 'express'
const allianceRouter = express.Router()
import allianceController from './alliance.controller.js'


allianceRouter.get('/', allianceController.readAlliances)
allianceRouter.post('/', allianceController.createAlliance)
allianceRouter.put('/:id', allianceController.updateAlliance)
allianceRouter.delete('/:id', allianceController.deleteAlliance)


export default allianceRouter