import pool from "../config/database.js"

const payment_methodRepository = {};

payment_methodRepository.readPayment_methods = async () => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_id()`);
    return resp.rows[0].sp_find_answer_by_id;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.readPayment_methodByName = async text => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_find_answer_by_name('${text}')`);
    return resp.rows[0].sp_find_answer_by_name;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.createPayment_method = async (name, amount, bank, type, idExam) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_create_answer('${name}', '${amount}', '${bank}', '${type}', ${idExam})`);
    return resp.rows[0].sp_create_answer;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.updatePayment_method = async (id, answer) => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_update_answer(${id}, '${answer.name}', '${answer.amount}', '${answer.bank}', '${answer.type}', ${answer.idExam})`);
    return resp.rows[0].sp_update_answer;
  } catch (error) {
    throw error;
  }
}

payment_methodRepository.deletePayment_method = async id => {
  try {
    await pool.query("SET SCHEMA 'cahub'");
    const resp = await pool.query(`SELECT * FROM cahub.sp_delete_answer(${id})`);
    return resp.rows[0].sp_delete_answer;
  } catch (error) {
    throw error;
  }
}

export default payment_methodRepository