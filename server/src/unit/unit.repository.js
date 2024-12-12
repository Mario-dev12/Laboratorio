import pool from "../config/database.js"

const unitRepository = {};

unitRepository.readUnits = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_unit()`);
    return resp.rows[0].sp_find_all_unit;
  } catch (error) {
    throw error;
  }
}

unitRepository.readUnitByName = async name => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

unitRepository.createUnit = async (name, idExam) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_answer('${name}', ${idExam})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

unitRepository.updateUnit = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_answer(${id}, '${answer.name}', ${answer.idExam})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

unitRepository.deleteUnit = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_unit(${id})`);
    return resp.rows[0].sp_delete_unit;
  } catch (error) {
    throw error;
  }
}

export default unitRepository