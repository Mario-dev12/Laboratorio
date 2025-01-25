import orderRepository from './order.repository.js'

const orderServices = {};

orderServices.readOrders = async () => {
    return await orderRepository.readOrders()
}

orderServices.readOrdersDay = async () => {
    return await orderRepository.readOrdersDay()
}

orderServices.readHistOrdersDay = async () => {
    return await orderRepository.readHistOrdersDay()
}

orderServices.createOrder = async (idExam, idProfile, status) => {
    return await orderRepository.createOrder(idExam, idProfile, status)
}

orderServices.updateOrder = async (id, answer) => {
    return await orderRepository.updateOrder(id, answer)
}

orderServices.deleteOrder = async id => {
    return await orderRepository.deleteOrder(id)
}

export default orderServices