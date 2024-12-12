import express from 'express'
const usersRouter = express.Router()
import usersController from './users.controller.js'


usersRouter.get('/', usersController.readUsers)
usersRouter.get('/:id', usersController.readUserById)
usersRouter.get('/name', usersController.readUserByName)
usersRouter.post('/', usersController.createUser)
usersRouter.put('/:id', usersController.updateUser)
usersRouter.delete('/:id', usersController.deleteUser)


export default usersRouter