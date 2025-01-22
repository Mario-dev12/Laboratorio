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
    
    const resp = await pool.query(`SELECT * FROM sp_find_unit_by_name('${name}')`);
    return resp.rows[0].sp_find_unit_by_name;
  } catch (error) {
    throw error;
  }
}

unitRepository.createUnit = async (name, idProfile) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_unit('${name}', ${idProfile})`);
    return resp.rows[0].sp_create_unit;
  } catch (error) {
    throw error;
  }
}

unitRepository.updateUnit = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_unit(${id}, '${answer.name}', ${answer.idProfile})`);
    return resp.rows[0].sp_update_unit;
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