import allianceRepository from './alliance.repository.js'

const allianceServices = {};

allianceServices.readAlliances = async () => {
    return await allianceRepository.readAlliances()
}

allianceServices.createAlliance = async (quantity, cost_bs, cost_usd, pay_done, pay_amount, idReactive, idProvider) => {
    return await allianceRepository.createAlliance(quantity, cost_bs, cost_usd, pay_done, pay_amount, idReactive, idProvider)
}

allianceServices.updateAlliance = async (id, answer) => {
    return await allianceRepository.updateAlliance(id, answer)
}

allianceServices.deleteAlliance = async id => {
    return await allianceRepository.deleteAlliance(id)
}

export default allianceServices