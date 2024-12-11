import pool from "../config/database.js"

const examRepository = {};

examRepository.readExams = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

examRepository.readExamByType = async text => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${text}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

examRepository.createExam = async (name, cost_bs, cost_usd, status, idUser) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${name}', '${cost_bs}', '${cost_usd}', '${status}', ${idUser})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

examRepository.updateExam = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.name}', '${answer.cost_bs}', '${answer.cost_usd}', '${answer.status}', ${answer.idUser})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

examRepository.deleteExam = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default examRepository