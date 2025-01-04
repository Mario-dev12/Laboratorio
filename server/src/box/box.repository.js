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

export default boxRepository