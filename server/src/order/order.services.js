import orderRepository from './order.repository.js'

const orderServices = {};

orderServices.readOrders = async () => {
    return await orderRepository.readOrders()
}

orderServices.readOrderByExamIdAndProfileId = async (idexam, idprofile) => {
    return await orderRepository.readOrderByExamIdAndProfileId(idexam, idprofile)
}

orderServices.readOrderByExamId = async id => {
    return await orderRepository.readOrderByExamId(id)
}

orderServices.readOrdersDay = async (today, date) => {
    return await orderRepository.readOrdersDay(today, date)
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

orderServices.deleteOrderByExamIdAndProfileId = async (idexam, idprofile) => {
    return await orderRepository.deleteOrderByExamIdAndProfileId(idexam, idprofile)
}

export default orderServices