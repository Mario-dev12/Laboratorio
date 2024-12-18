import providersServices from './providers.services.js'

const providersController = {};

providersController.readProviders = async (req, res) => {
    try {
      const answer = await providersServices.readProviders()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

providersController.readProviderByName = async (req, res) => {
    try {
      const { name } = req.params
      const answer = await usersServices.readUserByName(name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

providersController.createProvider = async (req, res) => {
  try {
    const answer = await providersServices.createProvider(req.body.name)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

providersController.updateProvider = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await providersServices.updateProvider(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

providersController.deleteProvider = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await providersServices.deleteProvider(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default providersController