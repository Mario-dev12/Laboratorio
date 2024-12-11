import express from 'express'
const providersRouter = express.Router()
import providersController from './providers.controller.js'


providersRouter.get('/', providersController.readProviders)
providersRouter.get('/name', providersController.readProviderByName)
providersRouter.post('/', providersController.createProvider)
providersRouter.put('/:id', providersController.updateProvider)
providersRouter.delete('/:id', providersController.deleteProvider)


export default providersRouter