import boxRepository from './box.repository.js'

const boxServices = {};

boxServices.readIncome = async (all, startDate, endDate) => {
    return await boxRepository.readIncome(all, startDate, endDate)
}

boxServices.readBills = async (all, startDate, endDate) => {
    return await boxRepository.readBills(all, startDate, endDate)
}

export default boxServices