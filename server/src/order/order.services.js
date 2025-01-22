import orderRepository from './order.repository.js'

const orderServices = {};

orderServices.readOrders = async () => {
    return await orderRepository.readOrders()
}

orderServices.createOrder = async (idExam, idProfile) => {
    return await orderRepository.createOrder(idExam, idProfile)
}

orderServices.updateOrder = async (id, answer) => {
    return await orderRepository.updateOrder(id, answer)
}

orderServices.deleteOrder = async id => {
    return await orderRepository.deleteOrder(id)
}

export default orderServices