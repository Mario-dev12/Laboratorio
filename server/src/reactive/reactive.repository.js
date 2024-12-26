import pool from "../config/database.js"

const reactiveRepository = {};

reactiveRepository.readReactives = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_reactive()`);
    return resp.rows[0].sp_find_all_reactive;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.readReactivesQuantity = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_quantity_reactive()`);
    return resp.rows[0].sp_find_all_quantity_reactive;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.readReactiveByName = async name => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_reactive_by_name('${name}')`);
    return resp.rows[0].sp_find_reactive_by_name;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.readReactivesByProvider = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_reactive_by_providers()`);
    return resp.rows[0].sp_find_all_reactive_by_providers;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.createReactive = async (name, total) => {
  try {
    console.log('ssssssss', name, total)
    const resp = await pool.query(`SELECT * FROM sp_create_reactive('${name}', ${total})`);
    return resp.rows[0].sp_create_reactive;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.updateReactive = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_reactive(${id}, '${answer.name}', ${answer.total})`);
    return resp.rows[0].sp_update_reactive;
  } catch (error) {
    throw error;
  }
}

reactiveRepository.deleteReactive = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_reactive(${id})`);
    return resp.rows[0].sp_delete_reactive;
  } catch (error) {
    throw error;
  }
}

export default reactiveRepository