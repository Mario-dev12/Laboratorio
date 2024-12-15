import payment_methodRepository from './payment_method.repository.js'

const payment_methodServices = {};

payment_methodServices.readPayment_methods = async () => {
    return await payment_methodRepository.readPayment_methods()
}
  
payment_methodServices.readPayment_methodByName = async name => {
    return await payment_methodRepository.readPayment_methodByName(name)
}

payment_methodServices.createPayment_method = async (name, amount, bank, type, idExam) => {
    return await payment_methodRepository.createPayment_method(name, amount, bank, type, idExam)
}

payment_methodServices.updatePayment_method = async (id, answer) => {
    return await payment_methodRepository.updatePayment_method(id, answer)
}

payment_methodServices.deletePayment_method = async id => {
    return await payment_methodRepository.deletePayment_method(id)
}

export default payment_methodServices