import pool from "../config/database.js"

const usersRepository = {};

usersRepository.readUsers = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_users()`);
    return resp.rows[0].sp_find_all_users;
  } catch (error) {
    throw error;
  }
}

usersRepository.readUserById = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_user_by_id('${id}')`);
    return resp.rows[0].sp_find_user_by_id;
  } catch (error) {
    throw error;
  }
}

usersRepository.readUserByName = async name => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_user_by_name('${name}')`);
    return resp.rows[0].sp_find_user_by_name;
  } catch (error) {
    throw error;
  }
}

usersRepository.createUser = async (ci, passport, firstName, lastName, genre, age, address) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_users('${ci}', '${passport}', '${firstName}', '${lastName}', '${genre}', ${age}, '${address}')`);
    return resp.rows[0].sp_create_users;
  } catch (error) {
    throw error;
  }
}

usersRepository.updateUser = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_users(${id}, '${answer.ci}', '${answer.passport}', '${answer.firstName}', '${answer.lastName}', '${answer.genre}', ${answer.age}, '${answer.address}')`);
    return resp.rows[0].sp_update_users;
  } catch (error) {
    throw error;
  }
}

usersRepository.deleteUser = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_users(${id})`);
    return resp.rows[0].sp_delete_users;
  } catch (error) {
    throw error;
  }
}

export default usersRepository