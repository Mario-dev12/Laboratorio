import allianceRepository from './alliance.repository.js'

const allianceServices = {};

allianceServices.readAlliances = async () => {
    return await allianceRepository.readAlliances()
}

allianceServices.createAlliance = async (quantity, idReactive, idProvider) => {
    return await allianceRepository.createAlliance(quantity, idReactive, idProvider)
}

allianceServices.updateAlliance = async (id, answer) => {
    return await allianceRepository.updateAlliance(id, answer)
}

allianceServices.deleteAlliance = async id => {
    return await allianceRepository.deleteAlliance(id)
}

export default allianceServices