import express from 'express'
const examRouter = express.Router()
import examController from './exam.controller.js'


examRouter.get('/', examController.readExams)
examRouter.post('/', examController.createExam)
examRouter.put('/:id', examController.updateExam)
examRouter.delete('/:id', examController.deleteExam)


export default examRouter