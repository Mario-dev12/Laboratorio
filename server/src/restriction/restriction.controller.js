import restrictionServices from './restriction.services.js'

const restrictionController = {};

restrictionController.readRestrictions = async (req, res) => {
    try {
      const answer = await restrictionServices.readRestrictions()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

restrictionController.readRestrictionByProfile = async (req, res) => {
    try {
      const { id } = req.params
      const answer = await restrictionServices.readRestrictionByProfile(id)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

restrictionController.createRestriction = async (req, res) => {
  try {
    const answer = await restrictionServices.createRestriction(req.body.idProfile, req.body.restriction)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

restrictionController.updateRestriction = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await restrictionServices.updateRestriction(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

restrictionController.deleteRestriction = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await restrictionServices.deleteRestriction(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default restrictionController