import examServices from './exam.services.js'

const examController = {};

examController.readExams = async (req, res) => {
    try {
      const answer = await examServices.readExams()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

examController.readExamByType = async (req, res) => {
    try {
      const answer = await examServices.readExamByType(req.body.name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

examController.createExam = async (req, res) => {
  try {
    const answer = await examServices.createExam(req.body.name, req.body.cost_bs, req.body.cost_usd, req.body.status, req.body.idUser)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

examController.updateExam = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await examServices.updateExam(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

examController.deleteExam = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await examServices.deleteExam(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default examController