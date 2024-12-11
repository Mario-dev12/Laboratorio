import pool from "../config/database.js"

const usersRepository = {};

usersRepository.readUsers = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

usersRepository.readUserByName = async name => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${name}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

usersRepository.createUser = async (ci, passport, firstName, lastName, genre, age, address) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${ci}', '${passport}', '${firstName}', '${lastName}', '${genre}', ${age}, '${address}')`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

usersRepository.updateUser = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.ci}', '${answer.passport}', '${answer.firstName}', '${answer.lastName}', '${answer.genre}', ${answer.age}, '${answer.address}')`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

usersRepository.deleteUser = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default usersRepository