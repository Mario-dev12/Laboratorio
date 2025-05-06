import boxRepository from './box.repository.js'

const boxServices = {};

boxServices.readIncome = async (all, startDate, endDate) => {
    return await boxRepository.readIncome(all, startDate, endDate)
}

boxServices.readBills = async (all, startDate, endDate) => {
    return await boxRepository.readBills(all, startDate, endDate)
}

boxServices.readDebt = async (all, startDate, endDate) => {
    return await boxRepository.readDebt(all, startDate, endDate)
}

boxServices.createDebt = async (idExam, deuda_bs, deuda_dolar, tasa) => {  
    return await boxRepository.createDebt(idExam, deuda_bs, deuda_dolar, tasa);  
};

boxServices.deleteDebt = async id => {
    return await boxRepository.deleteDebt(id)
}

boxServices.deleteDebtExam = async id => {
    return await boxRepository.deleteDebtExam(id)
}

export default boxServices