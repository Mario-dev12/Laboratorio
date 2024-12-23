import allianceServices from './alliance.services.js'

const allianceController = {};

allianceController.readAlliances = async (req, res) => {
    try {
      const answer = await allianceServices.readAlliances()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

allianceController.createAlliance = async (req, res) => {
  try {
    const answer = await allianceServices.createAlliance(req.body.quantity, req.body.cost_bs, req.body.cost_usd, req.body.pay_done, req.body.pay_amount, req.body.idReactive, req.body.idProvider)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

allianceController.updateAlliance = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await allianceServices.updateAlliance(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

allianceController.deleteAlliance = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await allianceServices.deleteAlliance(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default allianceController