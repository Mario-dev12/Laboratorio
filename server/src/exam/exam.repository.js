import pool from "../config/database.js"

const examRepository = {};

examRepository.readExams = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_exam()`);
    return resp.rows[0].sp_find_all_exam;
  } catch (error) {
    throw error;
  }
}

examRepository.createExam = async (idUser, total_cost_bs, total_cost_usd) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_create_exam(${idUser}, '${total_cost_bs}', '${total_cost_usd}')`);
    return resp.rows[0].sp_create_exam;
  } catch (error) {
    throw error;
  }
}

examRepository.updateExam = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_exam(${id}, ${answer.idUser}, ${answer.idProfile}, '${answer.total_cost_bs}', '${answer.total_cost_usd}')`);
    return resp.rows[0].sp_update_exam;
  } catch (error) {
    throw error;
  }
}

examRepository.deleteExam = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_exam(${id})`);
    return resp.rows[0].sp_delete_exam;
  } catch (error) {
    throw error;
  }
}

export default examRepository