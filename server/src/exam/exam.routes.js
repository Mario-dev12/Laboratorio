import express from 'express'
const examRouter = express.Router()
import examController from './exam.controller.js'


examRouter.get('/', examController.readExams)
examRouter.get('/type', examController.readExamByType)
examRouter.post('/', examController.createExam)
examRouter.put('/:id', examController.updateExam)
examRouter.delete('/:id', examController.deleteExam)


export default examRouter