import unitServices from './unit.services.js'

const unitController = {};

unitController.readUnits = async (req, res) => {
    try {
      const answer = await unitServices.readUnits()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

unitController.readUnitByName = async (req, res) => {
    try {
      const name = req.query.name;
      const answer = await unitServices.readUnitByName(name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

unitController.createUnit = async (req, res) => {
  try {
    const answer = await unitServices.createUnit(req.body.name, req.body.idProfile)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

unitController.updateUnit = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await unitServices.updateUnit(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

unitController.deleteUnit = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await unitServices.deleteUnit(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default unitController