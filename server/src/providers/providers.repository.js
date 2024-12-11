import pool from "../config/database.js"

const providersRepository = {};

providersRepository.readProviders = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

providersRepository.readProviderByName = async name => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

providersRepository.createProvider = async (name) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${name}')`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

providersRepository.updateProvider = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.name}')`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

providersRepository.deleteProvider = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default providersRepository