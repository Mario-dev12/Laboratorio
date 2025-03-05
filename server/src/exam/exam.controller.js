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

examController.createExam = async (req, res) => {
  try {
    const answer = await examServices.createExam(req.body.idUser, req.body.total_cost_bs, req.body.total_cost_usd)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

examController.createExamResults = async (req, res) => {  
  try {  
    const resultados = await examServices.createExamResults(req.body);  
    res.send(resultados);  
  } catch (error) {  
    return res.status(400).send(error.stack);  
  }  
}; 

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