import orderServices from './order.services.js'

const orderController = {};

orderController.readOrders = async (req, res) => {
    try {
      const answer = await orderServices.readOrders()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

orderController.readOrderByExamIdAndProfileId = async (req, res) => {
  const { idexam, idprofile } = req.params
  try {
    const answer = await orderServices.readOrderByExamIdAndProfileId(idexam, idprofile)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.readOrderByExamId = async (req, res) => {
  const { id } = req.params
  try {
    const answer = await orderServices.readOrderByExamId(id)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.readOrdersDay = async (req, res) => {
  const today = req.query.today;
  const date = req.query.date;
  try {
    const answer = await orderServices.readOrdersDay(today, date)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.readHistOrdersDay = async (req, res) => {
  try {
    const answer = await orderServices.readHistOrdersDay()

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.createOrder = async (req, res) => {
  try {
    const answer = await orderServices.createOrder(req.body.idExam, req.body.idProfile, req.body.status)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.updateOrder = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await orderServices.updateOrder(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

orderController.updateStatusOrder = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await orderServices.updateStatusOrder(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

orderController.deleteOrder = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await orderServices.deleteOrder(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

orderController.deleteOrderByExamIdAndProfileId = async (req, res) => {
  const { idexam, idprofile } = req.params

  try {
    const answer = await orderServices.deleteOrderByExamIdAndProfileId(idexam, idprofile)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default orderController