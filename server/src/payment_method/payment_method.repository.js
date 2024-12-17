import pool from "../config/database.js"

const payment_methodRepository = {};

payment_methodRepository.readPayment_methods = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_payment_method()`);
    return resp.rows[0].sp_find_all_payment_method;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.readPayment_methodByName = async text => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_payment_method_by_name('${text}')`);
    return resp.rows[0].sp_find_payment_method_by_name;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.createPayment_method = async (name, amount, bank, type, idExam) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_payment_method('${name}', '${amount}', '${bank}', '${type}', ${idExam})`);
    return resp.rows[0].sp_create_payment_method;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.updatePayment_method = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_payment_method(${id}, '${answer.name}', '${answer.amount}', '${answer.bank}', '${answer.type}', ${answer.idExam})`);
    return resp.rows[0].sp_update_payment_method;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.deletePayment_method = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_payment_method(${id})`);
    return resp.rows[0].sp_delete_payment_method;
  } catch (error) {
    throw error;
  }
}

export default payment_methodRepository