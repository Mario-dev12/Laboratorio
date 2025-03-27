import express from 'express'
const restrictionRouter = express.Router()
import restrictionController from './restriction.controller.js'


restrictionRouter.get('/', restrictionController.readRestrictions)
restrictionRouter.get('/:id', restrictionController.readRestrictionByProfile)
restrictionRouter.post('/', restrictionController.createRestriction)
restrictionRouter.put('/:id', restrictionController.updateRestriction)
restrictionRouter.delete('/:id', restrictionController.deleteRestriction)


export default restrictionRouter