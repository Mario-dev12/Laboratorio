import pool from "../config/database.js"

const allianceRepository = {};

allianceRepository.readAlliances = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_alliance()`);
    return resp.rows[0].sp_find_all_alliance;
  } catch (error) {
    throw error;
  }
}

allianceRepository.createAlliance = async (quantity, cost_bs, cost_usd, pay_done, pay_amount, idReactive, idProvider) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_alliance(${quantity}, '${cost_bs}', '${cost_usd}', ${pay_done}, '${pay_amount}', ${idReactive}, ${idProvider})`);
    return resp.rows[0].sp_create_alliance;
  } catch (error) {
    throw error;
  }
}

allianceRepository.updateAlliance = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_alliance(${id}, ${answer.quantity}, '${answer.cost_bs}', '${answer.cost_usd}', ${answer.pay_done}, '${answer.pay_amount}', ${answer.idReactive}, ${answer.idProvider})`);
    return resp.rows[0].sp_update_alliance;
  } catch (error) {
    throw error;
  }
}

allianceRepository.deleteAlliance = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_alliance(${id})`);
    return resp.rows[0].sp_delete_alliance;
  } catch (error) {
    throw error;
  }
}

export default allianceRepository