import paymentServices from './payment.services.js'

const paymentController = {};

paymentController.readPayments = async (req, res) => {
    try {
      const answer = await paymentServices.readPayments()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

paymentController.readPaymentByExamIdAndPaymentMethodid = async (req, res) => {
  const { idexam, idpayment_method } = req.params
  try {
    const answer = await paymentServices.readPaymentByExamIdAndPaymentMethodid(idexam, idpayment_method)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

paymentController.readPaymentByExamId = async (req, res) => {
  const { id } = req.params
  try {
    const answer = await paymentServices.readPaymentByExamId(id)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

paymentController.createPayment = async (req, res) => {
  try {
    const answer = await paymentServices.createPayment(req.body.idPayment_method, req.body.idExam, req.body.amount_bs, req.body.amount_usd, req.body.bank, req.body.phone, req.body.type)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

paymentController.updatePayment = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await paymentServices.updatePayment(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

paymentController.deletePayment = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await paymentServices.deletePayment(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default paymentController