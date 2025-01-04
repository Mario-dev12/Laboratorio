import boxServices from './box.services.js'

const boxController = {};

boxController.readIncome = async (req, res) => {
    try {
      const all = req.query.all;
      const startDate = req.query.startDate;
      const endDate = req.query.endDate;
      
      const answer = await boxServices.readIncome(all, startDate, endDate)
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

boxController.readBills = async (req, res) => {
  try {
    const all = req.query.all;
    const startDate = req.query.startDate;
    const endDate = req.query.endDate;

    const answer = await boxServices.readBills(all, startDate, endDate)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

export default boxController