import pool from "../config/database.js"

const paymentRepository = {};

paymentRepository.readPayments = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_payment()`);
    return resp.rows[0].sp_find_all_payment;
  } catch (error) {
    throw error;
  }
}

paymentRepository.createPayment = async (idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) => {
  try {

    const resp = await pool.query(`SELECT * FROM sp_create_payment(${idPayment_method}, ${idExam}, '${amount_bs}', '${amount_usd}', '${bank}', '${phone}', '${type}')`);
    return resp.rows[0].sp_create_payment;
  } catch (error) {
    throw error;
  }
}

paymentRepository.updatePayment = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_payment(${id}, ${answer.idPayment_method}, ${answer.idExam}, '${answer.amount_bs}', '${answer.amount_usd}', '${answer.bank}', '${answer.phone}', '${answer.type}')`);
    return resp.rows[0].sp_update_payment;
  } catch (error) {
    throw error;
  }
}

paymentRepository.deletePayment = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_payment(${id})`);
    return resp.rows[0].sp_delete_payment;
  } catch (error) {
    throw error;
  }
}

export default paymentRepository