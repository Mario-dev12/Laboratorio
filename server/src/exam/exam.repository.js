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

examRepository.readExamByType = async name => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

examRepository.createExam = async (name, cost_bs, cost_usd, status, idUser) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_answer('${name}', '${cost_bs}', '${cost_usd}', '${status}', ${idUser})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

examRepository.updateExam = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_answer(${id}, '${answer.name}', '${answer.cost_bs}', '${answer.cost_usd}', '${answer.status}', ${answer.idUser})`);
    return resp.rows[0].sp_update_answer;
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