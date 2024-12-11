import pool from "../config/database.js"

const reactiveRepository = {};

reactiveRepository.readReactives = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.readReactiveByName = async name => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.createReactive = async (name, quantity, idExam) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${name}', ${quantity}, ${idExam})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.updateReactive = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.name}', ${answer.quantity}, ${answer.idExam})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.deleteReactive = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default reactiveRepository