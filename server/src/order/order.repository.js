import pool from "../config/database.js"

const orderRepository = {};

orderRepository.readOrders = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_order()`);
    return resp.rows[0].sp_find_all_order;
  } catch (error) {
    throw error;
  }
}

orderRepository.readOrderByExamIdAndProfileId = async (idexam, idprofile) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_order_by_examidandprofileid(${idexam}, ${idprofile})`);
    return resp.rows[0].sp_find_order_by_examidandprofileid;
  } catch (error) {
    throw error;
  }
}

orderRepository.readOrderByExamId = async (id) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_find_order_by_examId(${id})`);
    return resp.rows[0].sp_find_order_by_examid;
  } catch (error) {
    throw error;
  }
}

orderRepository.readOrdersDay = async (today, date) => {
  try {
    console.log('llega', today, date)
    const resp = await pool.query(`SELECT * FROM sp_find_all_order_day('${today}', '${date}')`);
    return resp.rows[0].sp_find_all_order_day;
  } catch (error) {
    throw error;
  }
}

orderRepository.readHistOrdersDay = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_hist_order_day()`);
    return resp.rows[0].sp_find_all_hist_order_day;
  } catch (error) {
    throw error;
  }
}

orderRepository.createOrder = async (idExam, idProfile, status) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_order(${idExam}, ${idProfile}, '${status}')`);
    return resp.rows[0].sp_create_order;
  } catch (error) {
    throw error;
  }
}

orderRepository.updateOrder = async (id, answer) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_update_order(${id}, ${answer.idExam}, ${answer.idProfile}, '${answer.status}')`);
    return resp.rows[0].sp_update_order;
  } catch (error) {
    throw error;
  }
}

orderRepository.deleteOrder = async id => {
  try {
    console.log('llega', id)
    const resp = await pool.query(`SELECT * FROM sp_delete_order(${id})`);
    return resp.rows[0].sp_delete_order;
  } catch (error) {
    throw error;
  }
}

orderRepository.deleteOrderByExamIdAndProfileId = async (idexam, idprofile) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_order_by_examid_and_profileid(${idexam}, ${idprofile})`);
    return resp.rows[0].sp_delete_order_by_examid_and_profileid;
  } catch (error) {
    throw error;
  }
}

export default orderRepository