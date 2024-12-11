import pool from "../config/database.js"

const allianceRepository = {};

allianceRepository.readAlliances = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

allianceRepository.createAlliance = async (quantity, idReactive, idProvider) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer(${quantity}, ${idReactive}, ${idProvider})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

allianceRepository.updateAlliance = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, ${answer.quantity}, ${answer.idReactive}, ${answer.idProvider})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

allianceRepository.deleteAlliance = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default allianceRepository