import usersServices from './users.services.js'

const usersController = {};

usersController.readUsers = async (req, res) => {
    try {
      const answer = await usersServices.readUsers()
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

usersController.readUserByName = async (req, res) => {
    try {
      const answer = await usersServices.readUserByName(req.body.name)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

usersController.createUser = async (req, res) => {
  try {
    const answer = await usersServices.createUser(req.body.ci, req.body.passport, req.body.firstName, req.body.lastName, req.body.genre, req.body.age, req.body.address)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

usersController.updateUser = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await usersServices.updateUser(id, req.body)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.message)
  }
}

usersController.deleteUser = async (req, res) => {
  const { id } = req.params

  try {
    const answer = await usersServices.deleteUser(id)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default usersController