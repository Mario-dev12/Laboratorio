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

allianceRepository.createAlliance = async (quantity, idReactive, idProvider) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_answer(${quantity}, ${idReactive}, ${idProvider})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

allianceRepository.updateAlliance = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_answer(${id}, ${answer.quantity}, ${answer.idReactive}, ${answer.idProvider})`);
    return resp.rows[0].sp_update_answer;
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