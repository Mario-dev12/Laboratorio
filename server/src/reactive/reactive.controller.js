import reactiveServices from './reactive.services.js'

const reactiveController = {};

reactiveController.readReactives = async (req, res) => {
    try {
      const answer = await reactiveServices.readReactives()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

reactiveController.readReactivesQuantity = async (req, res) => {
  try {
    const answer = await reactiveServices.readReactivesQuantity()

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

reactiveController.readReactiveByName = async (req, res) => {
    try {
      const { name } = req.params
      const answer = await reactiveServices.readReactiveByName(name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

reactiveController.readReactivesByProvider = async (req, res) => {
  try {
    const answer = await reactiveServices.readReactivesByProvider()

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

reactiveController.createReactive = async (req, res) => {
  try {
    const answer = await reactiveServices.createReactive(req.body.name)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

reactiveController.updateReactive = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await reactiveServices.updateReactive(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

reactiveController.deleteReactive = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await reactiveServices.deleteReactive(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default reactiveController