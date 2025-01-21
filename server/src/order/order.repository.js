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

orderRepository.createOrder = async (idExam, idProfile) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_create_order(${idExam}, ${idProfile})`);
    return resp.rows[0].sp_create_order;
  } catch (error) {
    throw error;
  }
}

orderRepository.updateOrder = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_exam(${id}, ${answer.idExam}, ${answer.idProfile})`);
    return resp.rows[0].sp_update_exam;
  } catch (error) {
    throw error;
  }
}

orderRepository.deleteOrder = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_order(${id})`);
    return resp.rows[0].sp_delete_order;
  } catch (error) {
    throw error;
  }
}

export default orderRepository