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

boxController.readDebt = async (req, res) => {
  try {
    const all = req.query.all;
    const startDate = req.query.startDate;
    const endDate = req.query.endDate;
    
    const answer = await boxServices.readDebt(all, startDate, endDate)

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

boxController.createDebt = async (req, res) => {
	try {
		const resultados = await boxServices.createDebt(req.body.idExam, req.body.deuda_bs, req.body.deuda_dolar, req.body.tasa);
		res.send(resultados);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

boxController.deleteDebt = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await boxServices.deleteDebt(id);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

export default boxController