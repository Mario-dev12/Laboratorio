import paymentRepository from './payment.repository.js'

const paymentServices = {};

paymentServices.readPayments = async () => {
    return await paymentRepository.readPayments()
}

paymentServices.createPayment = async (idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) => {
    return await paymentRepository.createPayment(idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type)
}

paymentServices.updatePayment = async (id, answer) => {
    return await paymentRepository.updatePayment(id, answer)
}

paymentServices.deletePayment = async id => {
    return await paymentRepository.deletePayment(id)
}

export default paymentServices