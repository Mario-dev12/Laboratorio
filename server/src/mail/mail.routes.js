import express from 'express'
const mailRouter = express.Router()
import mailController from './mail.controller.js'


mailRouter.post('/', mailController.sendMail)


export default mailRouter