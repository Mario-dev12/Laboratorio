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

orderController.readOrdersDay = async (req, res) => {
  try {
    const answer = await orderServices.readOrdersDay()

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

orderController.deleteOrder = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await orderServices.deleteOrder(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default orderController