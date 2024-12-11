import pool from "../config/database.js"

const unitRepository = {};

unitRepository.readUnits = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

unitRepository.readUnitByName = async name => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

unitRepository.createUnit = async (name, idExam) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${name}', ${idExam})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

unitRepository.updateUnit = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.name}', ${answer.idExam})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

unitRepository.deleteUnit = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default unitRepository