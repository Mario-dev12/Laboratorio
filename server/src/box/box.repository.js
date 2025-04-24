import pool from "../config/database.js"

const boxRepository = {};

boxRepository.readIncome = async (all, startDate, endDate) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_income(${all}, '${startDate}', '${endDate}')`);
    return resp.rows[0].sp_find_all_income;
  } catch (error) {
    throw error;
  }
}

boxRepository.readBills = async (all, startDate, endDate) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_bills(${all}, '${startDate}', '${endDate}')`);
    return resp.rows[0].sp_find_all_bills;
  } catch (error) {
    throw error;
  }
}

boxRepository.readDebt = async (all, startDate, endDate) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_find_all_debt(${all}, '${startDate}', '${endDate}')`);
    return resp.rows[0].sp_find_all_debt;
  } catch (error) {
    throw error;
  }
}

boxRepository.createDebt = async (idExam, deuda_bs, deuda_dolar, tasa) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_debt(${idExam}, '${deuda_bs}', '${deuda_dolar}', '${tasa}')`);
    return resp.rows[0].sp_create_debt;
  } catch (error) {
    throw error;
  }
}

boxRepository.deleteDebt = async (id) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_delete_debt(${id})`);
		return resp.rows[0].sp_delete_debt;
	} catch (error) {
		throw error;
	}
};

export default boxRepository