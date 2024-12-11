import payment_methodServices from './answer.services.js'

const payment_methodController = {};

payment_methodController.readPayment_methods = async (req, res) => {
    try {
      const answer = await payment_methodServices.readPayment_methods()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

payment_methodController.readPayment_methodByName = async (req, res) => {
    try {
      const answer = await payment_methodServices.readPayment_methodByName(req.body.name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

payment_methodController.createPayment_method = async (req, res) => {
  try {
    const answer = await payment_methodServices.createPayment_method(req.body.name, req.body.amount, req.body.bank, req.body.type, req.body.idExam)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

payment_methodController.updatePayment_method = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await payment_methodServices.updatePayment_method(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

payment_methodController.deletePayment_method = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await payment_methodServices.deletePayment_method(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default payment_methodController