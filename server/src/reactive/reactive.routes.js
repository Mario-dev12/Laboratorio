import express from 'express'
const reactiveRouter = express.Router()
import reactiveController from './reactive.controller.js'


reactiveRouter.get('/', reactiveController.readReactives)
reactiveRouter.get('/quantity', reactiveController.readReactivesQuantity)
reactiveRouter.get('/name/:name', reactiveController.readReactiveByName)
reactiveRouter.get('/provider', reactiveController.readReactivesByProvider)
reactiveRouter.post('/', reactiveController.createReactive)
reactiveRouter.put('/:id', reactiveController.updateReactive)
reactiveRouter.delete('/:id', reactiveController.deleteReactive)


export default reactiveRouter